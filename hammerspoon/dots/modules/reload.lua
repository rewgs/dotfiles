require('modules.mod-keys')

hs.hotkey.bind(mod.hyper, 'r', function()
    hs.reload()
end)
hs.alert.show('config reloaded', 3)
