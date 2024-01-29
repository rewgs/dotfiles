require('mod-keys')

TERMINAL = 'iTerm'
BROWSER = 'Google Chrome'

local app_maps = {
    { key = 'i',      app = BROWSER },
    { key = 'v',      app = 'Visual Studio Code' },
    -- TODO: make this show desktop
    { key = 'd',      app = 'Discord' }, -- would like to key-chord this so that mod.hyper+m,{something} calls different messaging apps, e.g. mod.hyper+m,d calls Discord
    { key = 'f',      app = 'Finder' },
    { key = 'return', app = TERMINAL }
}

for _, map in ipairs(app_maps) do
    hs.hotkey.bind(mod.hyper, map.key,
        function()
            hs.application.launchOrFocus(map.app)
        end
    )
end
