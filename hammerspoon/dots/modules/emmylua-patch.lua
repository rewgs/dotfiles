--- Patch EmmyLua's generated annotations so submodules appear in completion.
---
--- EmmyLua declares e.g. `---@class hs` / `---@class hs.window` but never adds
--- `@field` entries for child modules. Each child only attaches via a cross-file
--- global assignment (`hs.window = M`, `hs.window.filter = M`), which lua_ls does
--- not fold into completion once the parent has an explicit class. Result: typing
--- `hs.` or `hs.window.` completes functions but not the nested modules.
---
--- For every `hs.*` annotation file this module injects `---@field <seg> <child>`
--- lines under that file's own `---@class` declaration, one per immediate child
--- module — so the full chain (hs -> hs.window -> hs.window.filter -> ...) is
--- reachable at any depth. It is idempotent and only writes files that actually
--- changed, so it won't churn mtimes or trip pathwatchers.
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

	local patchedFiles, totalFields = 0, 0
	for _, parent in ipairs(names) do
		local kids = childrenOf(parent, names)
		if #kids > 0 then
			local file = dir .. "/" .. parent .. ".lua"
			local content = readFile(file)
			if content then
				local rebuilt = rebuildFields(content, parent, kids)
				if rebuilt then
					if writeFile(file, rebuilt) then
						patchedFiles = patchedFiles + 1
						totalFields = totalFields + #kids
					else
						log.e("failed to write " .. file)
					end
				end
			end
		end
	end

	if patchedFiles > 0 then
		log.i(string.format("patched %d annotation file(s), %d submodule @field entries", patchedFiles, totalFields))
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
