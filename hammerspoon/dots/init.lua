-- Enables inter-process communication
-- https://www.hammerspoon.org/docs/hs.ipc.html
require("hs.ipc")
local ipcInstalled = hs.ipc.cliStatus()
if not ipcInstalled then
	local _ = hs.ipc.cliInstall()
	-- local success = hs.ipc.cliInstall()
	-- if not success then
	-- end
end

local spoons = os.getenv("HOME") .. "/src" .. "/Spoons" .. "/Spoons" .. "/?.spoon/init.lua"
package.path = package.path .. ";" .. spoons

-- Generate EmmyLua annotations for Hammerspoon (and any installed Spoons) so
-- editors running lua-language-server get autocomplete and type hints. Load it
-- before any pathwatcher (e.g. modules.reload) so regenerating annotations
-- doesn't trigger a config-reload loop. Annotations are written to the spoon's
-- own annotations/ dir; dots/.luarc.json points lua_ls at it.
hs.loadSpoon("EmmyLua")

-- EmmyLua's generated hs.lua lists hs.* functions but not its submodules
-- (hs.window, hs.screen, ...), so `hs.` completion misses them. Re-apply the
-- @field patch now, right after EmmyLua (re)generates annotations on load.
require("modules.emmylua-patch")

require("modules.mod")
require("modules.reload")
-- require("modules.apps.init")

-- NOTE: Using Phoenix for this until I can sort out Firefox.
-- require("modules.window-management")

-- require("modules.window-switcher")
-- require("modules.spaces")
-- require('modules.yabai') -- not yet ready for primetime...

-- local sns = os.getenv("HOME") .. "/.sns" .. "/env" .. "/hammerspoon" .. "/src" .. "/init.lua"
-- dofile(sns)
