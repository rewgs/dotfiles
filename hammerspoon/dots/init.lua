local spoons = os.getenv("HOME") .. "/src" .. "/Spoons" .. "/Spoons" .. "/?.spoon/init.lua"
package.path = package.path .. ";" .. spoons

require("modules.mod-keys")
require("modules.reload")
require("modules.apps.init")

-- NOTE: Using Phoenix for this until I can sort out Firefox.
-- require("modules.window-management")

-- require("modules.window-switcher")
-- require("modules.spaces")
-- require('modules.yabai') -- not yet ready for primetime...

local sns = os.getenv("HOME") .. "/.sns" .. "/env" .. "/hammerspoon" .. "/src" .. "/init.lua"
dofile(sns)
