require("modules.mod-keys")

hs.hotkey.bind(Mod.oHyper, "r", function()
	hs.reload()
end)
hs.alert.show("config reloaded", 3)
