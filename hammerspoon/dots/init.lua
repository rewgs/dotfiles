local spoons = os.getenv("HOME") .. "/src" .. "/Spoons" .. "/Spoons" .. "/?.spoon/init.lua"
-- local spoons = spoonsPath .. "/?.spoon/init.lua"
package.path = package.path .. ";" .. spoons

require("modules.mod-keys")
require("modules.reload")
-- require("modules.spaces")
require("modules.apps.init")

-- NOTE: Using Phoenix for this until I can sort out the Spoons path issue.
require("modules.window-management")

-- require('modules.window-switcher')
-- require('modules.yabai') -- not yet ready for primetime...
