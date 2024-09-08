-- This file specifies global shortcuts for opening or focusing apps.


require('mod-keys')
local HYPER = mod.hyper


local TERMINAL = 'wezterm'
local BROWSER = 'Google Chrome'
local ___ = 'return' -- makes formatting in `bindings` table cleaner


local bindings = {
    { mod = HYPER,  key = ___, app = TERMINAL   },
    { mod = HYPER,  key = 'e', app = 'Finder'   },
    { mod = HYPER,  key = 'i', app = BROWSER    },
    { mod = HYPER,  key = 'o', app = 'Obsidian' },
}


local function bind_keys(kbs)
    for _, b in ipairs(kbs) do
        hs.hotkey.bind(b.mod, b.key, function()
            hs.application.launchOrFocus(b.app)
        end)
    end
end
bind_keys(bindings)
