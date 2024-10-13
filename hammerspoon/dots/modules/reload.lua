require('modules.mod-keys')

hs.hotkey.bind(mod.oHyper, 'r', function()
    hs.reload()
end)
hs.alert.show('config reloaded', 3)
