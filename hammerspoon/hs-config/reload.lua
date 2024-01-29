require('mod-keys')

-- hs.hotkey.bind({'cmd', 'ctrl'}, 'R', function()
hs.hotkey.bind(mod.hyper, 'R', function()
    hs.reload()
end)
hs.alert.show('config reloaded')
