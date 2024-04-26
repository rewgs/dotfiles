require('mod-keys')

TERMINAL = 'iTerm'
BROWSER = 'Google Chrome'

local hyper_apps = {
    -- { key = 'i',      app = BROWSER },
    { key = 'v',      app = 'Visual Studio Code' },
    -- TODO: make this show desktop
    { key = 'd',      app = 'Discord' }, -- would like to key-chord this so that mod.hyper+m,{something} calls different messaging apps, e.g. mod.hyper+m,d calls Discord
    { key = 'f',      app = 'Finder' },
    { key = 'return', app = TERMINAL }
}

local sHyper_apps = {
    { key = 'e', app = 'Bartender 4' },
}

for _, map in ipairs(hyper_apps) do
    hs.hotkey.bind(mod.hyper, map.key,
        function()
            hs.application.launchOrFocus(map.app)
        end
    )
end

for _, map in ipairs(sHyper_apps) do
    hs.hotkey.bind(mod.sHyper, map.key,
        function()
            hs.application.launchOrFocus(map.app)
        end
    )
end

