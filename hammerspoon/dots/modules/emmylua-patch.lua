--- Patch EmmyLua's generated annotations so submodules and chained method return
--- types appear in completion.
---
--- Two separate gaps are fixed:
---
--- 1. Submodules (`@field`). EmmyLua declares e.g. `---@class hs` /
---    `---@class hs.window` but never adds `@field` entries for child modules.
---    Each child only attaches via a cross-file global assignment
---    (`hs.window = M`, `hs.window.filter = M`), which lua_ls does not fold into
---    completion once the parent has an explicit class. Result: typing `hs.` or
---    `hs.window.` completes functions but not the nested modules. For every
---    `hs.*` annotation file this module injects `---@field <seg> <child>` lines
---    under that file's own `---@class` declaration, one per immediate child
---    module — so the full chain (hs -> hs.window -> hs.window.filter -> ...) is
---    reachable at any depth.
---
--- 2. Return types (`@return`). EmmyLua only emits `---@return` when it can
---    resolve the terse return descriptor in a function's `def` signature. Its
---    resolver misses common shapes like `app or nil` (the descriptor for
---    `hs.window:application()`), so chained calls such as
---    `hs.window:application():title()` don't complete — lua_ls has no idea
---    `:application()` returns an `hs.application`. This module re-reads the
---    Hammerspoon docs JSON (`hs.docstrings_json_file`, the same source EmmyLua
---    uses) and, with a more forgiving resolver, injects a `---@return <type>`
---    line above any function that is missing one but whose return type is now
---    resolvable. Existing `---@return` lines are left untouched.
---
--- Both passes are idempotent and only write files that actually changed, so they
--- won't churn mtimes or trip pathwatchers.
---
--- Load it right after `hs.loadSpoon("EmmyLua")` (EmmyLua generates/regenerates
--- annotations synchronously during load, e.g. after a Hammerspoon upgrade), so
--- the patch is re-applied exactly when needed.

local log = hs.logger.new("emmylua-patch", "info")

local M = {}

-- Locate EmmyLua's annotations dir from the loaded spoon, with a sane fallback.
local function annotationsDir()
	local emmy = spoon and spoon.EmmyLua
	local base = emmy and emmy.spoonPath
	if not base then
		base = os.getenv("HOME") .. "/src/Spoons/Spoons/EmmyLua.spoon/"
	end
	if base:sub(-1) ~= "/" then
		base = base .. "/"
	end
	return base .. "annotations"
end

local function readFile(path)
	local fd = io.open(path, "r")
	if not fd then
		return nil
	end
	local content = fd:read("*a")
	fd:close()
	return content
end

local function writeFile(path, content)
	local fd = io.open(path, "w")
	if not fd then
		return false
	end
	fd:write(content)
	fd:close()
	return true
end

-- Split into lines, preserving a trailing newline as a final empty element so
-- table.concat(lines, "\n") round-trips the original content exactly.
local function splitLines(s)
	local lines = {}
	local pos = 1
	while true do
		local nl = s:find("\n", pos, true)
		if nl then
			lines[#lines + 1] = s:sub(pos, nl - 1)
			pos = nl + 1
		else
			lines[#lines + 1] = s:sub(pos)
			break
		end
	end
	return lines
end

-- Escape Lua-pattern magic chars so a module name (which contains ".") can be
-- used literally inside a pattern.
local function escapePattern(s)
	return (s:gsub("(%W)", "%%%1"))
end

-- Mirror of EmmyLua's own `options.types` lookup (init.lua): terse return
-- descriptors that map to a concrete annotation type.
local TYPE_MAP = {
	bool = "boolean",
	boolean = "boolean",
	["false"] = "boolean",
	["true"] = "boolean",
	string = "string",
	number = "number",
	float = "number",
	integer = "number",
	app = "hs.application",
	hsminwebtable = "hs.httpserver.hsminweb",
	notificationobject = "hs.notify",
	point = "hs.geometry",
	rect = "hs.geometry",
	["hs.geometry rect"] = "hs.geometry",
	size = "hs.geometry",
}

-- Resolve a `def` return descriptor (the text after `->`) to an annotation type.
-- Superset of EmmyLua's parseType: same rules, but also retries on the first
-- alternative of an `X or Y` descriptor so `app or nil` resolves to
-- hs.application, `device or nil` to hs.audiodevice, etc.
local function resolveType(moduleName, str)
	if not str then
		return nil
	end
	str = str:lower():gsub("^%s+", ""):gsub("%s+$", "")

	local function try(s)
		if s == "" then
			return nil
		end
		if TYPE_MAP[s] then
			return TYPE_MAP[s]
		end
		local t = s:match("^(hs%.[%w%.]*%w)%s*object")
		if t then
			return t
		end
		t = s:match("^list of (hs%.[%w%.]*%w)%s*object")
		if t then
			return t .. "[]"
		end
		-- EmmyLua's substring rule: e.g. "window" is contained in "hs.window".
		if moduleName:find(s, 1, true) or s == "self" then
			return moduleName
		end
		return nil
	end

	-- Whole descriptor first (handles "hs.geometry rect", "hs.x object", ...),
	-- then fall back to the first alternative before " or ".
	local t = try(str)
	if t then
		return t
	end
	local first = str:match("^(.-)%s+or%s+")
	if first then
		return try(first)
	end
	return nil
end

-- Build { [moduleName] = { [methodShortName] = returnType } } from a docs JSON
-- file (the array Hammerspoon ships at hs.docstrings_json_file).
local function buildReturnMap(docsPath)
	if not (docsPath and hs.fs.attributes(docsPath, "modification")) then
		return {}
	end
	local ok, data = pcall(hs.json.read, docsPath)
	if not ok or type(data) ~= "table" then
		return {}
	end

	local map = {}
	for _, module in ipairs(data) do
		local mname = module.name
		if mname then
			local methods = map[mname] or {}
			for _, item in ipairs(module.items or {}) do
				local def = item.def
				local ret = def and def:match("%-+>%s*(.+)$")
				local rtype = item.name and resolveType(mname, ret)
				if rtype then
					methods[item.name] = rtype
				end
			end
			map[mname] = methods
		end
	end
	return map
end

-- Insert `---@return <type>` above any `function M:foo()` / `function M.foo()`
-- line that lacks one but has a resolvable return type. Returns the new content
-- and how many lines were added, or nil when nothing changed.
local function injectReturns(content, returnMap)
	if not returnMap then
		return nil, 0
	end
	local lines = splitLines(content)
	local out = {}
	local added = 0
	for _, line in ipairs(lines) do
		local name = line:match("^function%s+M[:.]([%w_]+)%s*%(")
		if name then
			local rtype = returnMap[name]
			local prev = out[#out]
			if rtype and not (prev and prev:match("^%-%-%-@return%s")) then
				out[#out + 1] = "---@return " .. rtype
				added = added + 1
			end
		end
		out[#out + 1] = line
	end
	if added == 0 then
		return nil, 0
	end
	return table.concat(out, "\n"), added
end

-- All hs.* module names that have an annotation file, derived from filenames
-- (e.g. hs.lua -> "hs", hs.window.filter.lua -> "hs.window.filter").
local function listModules(dir)
	local names = {}
	if hs.fs.attributes(dir, "mode") ~= "directory" then
		return names
	end
	for entry in hs.fs.dir(dir) do
		local name = entry:match("^(.+)%.lua$")
		if name and (name == "hs" or name:match("^hs%.")) then
			names[#names + 1] = name
		end
	end
	return names
end

-- Immediate children of `parent`: modules named `parent.<seg>` with no further
-- dots in <seg>. Returns a sorted list of { seg = <field name>, type = <module> }.
local function childrenOf(parent, allNames)
	local pat = "^" .. escapePattern(parent) .. "%.([%w_]+)$"
	local kids = {}
	for _, name in ipairs(allNames) do
		local seg = name:match(pat)
		if seg then
			kids[#kids + 1] = { seg = seg, type = name }
		end
	end
	table.sort(kids, function(a, b)
		return a.seg < b.seg
	end)
	return kids
end

-- Rewrite the `---@field` block directly under `---@class <className>`. Returns
-- the new content, or nil if the class wasn't found or nothing changed.
local function rebuildFields(content, className, kids)
	local lines = splitLines(content)
	local classPat = "^%-%-%-@class%s+" .. escapePattern(className) .. "%s*$"

	local classIdx
	for i, line in ipairs(lines) do
		if line:match(classPat) then
			classIdx = i
			break
		end
	end
	if not classIdx then
		return nil
	end

	-- Drop any existing contiguous ---@field lines right after the class line.
	local tailStart = classIdx + 1
	while tailStart <= #lines and lines[tailStart]:match("^%-%-%-@field%s") do
		tailStart = tailStart + 1
	end

	local out = {}
	for i = 1, classIdx do
		out[#out + 1] = lines[i]
	end
	for _, k in ipairs(kids) do
		out[#out + 1] = "---@field " .. k.seg .. " " .. k.type
	end
	for i = tailStart, #lines do
		out[#out + 1] = lines[i]
	end

	local rebuilt = table.concat(out, "\n")
	if rebuilt == content then
		return nil
	end
	return rebuilt
end

--- Apply the patch. Safe to call repeatedly; no-op when already up to date.
function M.apply()
	local dir = annotationsDir()
	local names = listModules(dir)
	if #names == 0 then
		log.w("no hs.* annotation files found in " .. dir .. " (EmmyLua not generated yet?); skipping")
		return
	end

	local returnMap = buildReturnMap(hs.docstrings_json_file)

	local patchedFiles, totalFields, totalReturns = 0, 0, 0
	for _, parent in ipairs(names) do
		local file = dir .. "/" .. parent .. ".lua"
		local content = readFile(file)
		if content then
			local updated = content

			-- Pass 1: submodule @field entries.
			local kids = childrenOf(parent, names)
			if #kids > 0 then
				local rebuilt = rebuildFields(updated, parent, kids)
				if rebuilt then
					updated = rebuilt
					totalFields = totalFields + #kids
				end
			end

			-- Pass 2: missing @return annotations.
			local withReturns, added = injectReturns(updated, returnMap[parent])
			if withReturns then
				updated = withReturns
				totalReturns = totalReturns + added
			end

			if updated ~= content then
				if writeFile(file, updated) then
					patchedFiles = patchedFiles + 1
				else
					log.e("failed to write " .. file)
				end
			end
		end
	end

	if patchedFiles > 0 then
		log.i(string.format(
			"patched %d annotation file(s): %d submodule @field, %d @return entries",
			patchedFiles,
			totalFields,
			totalReturns
		))
	else
		log.i("annotations already up to date")
	end
end

-- Guard so a failure here never breaks config loading.
local ok, err = pcall(M.apply)
if not ok then
	log.e("patch failed: " .. tostring(err))
end

return M
