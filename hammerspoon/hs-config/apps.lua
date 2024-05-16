require('mod-keys')

local HYPER = mod.hyper
local SHYPER = mod.sHyper

TERMINAL = 'iTerm'
BROWSER = 'Google Chrome'

local bindings = {
    { mod = HYPER,  key = 'v',      app = 'Visual Studio Code' },
    { mod = HYPER,  key = 'd',      app = 'Discord' },
    { mod = HYPER,  key = 'f',      app = 'Finder' },
    { mod = HYPER,  key = 'return', app = TERMINAL },
    { mod = SHYPER, key = 'e',      app = 'Bartender 4' },
}

local function bind_keys(kbs)
    for _, b in ipairs(kbs) do
        hs.hotkey.bind(b.mod, b.key, function()
            hs.application.launchOrFocus(b.app)
        end)
    end
end
bind_keys(bindings)
