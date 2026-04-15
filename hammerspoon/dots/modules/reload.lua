require("modules.mod")

hs.hotkey.bind(Mod.Hyper, "r", function()
	hs.reload()
end)
hs.alert.show("config reloaded", 3)
