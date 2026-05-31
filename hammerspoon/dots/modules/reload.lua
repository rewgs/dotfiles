local mod = require("modules.mod").mod

hs.hotkey.bind(mod.Hyper, "r", function()
	hs.reload()
end)
hs.alert.show("config reloaded", 3)
