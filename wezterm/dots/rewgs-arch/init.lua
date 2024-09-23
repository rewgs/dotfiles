local module = {}

local appearance = require('rewgs-arch.appearance')
local font = require('rewgs-arch.font')

-- local keys = require('rewgs-arch.keys.standard')     -- ALT|CTRL as main mod
-- local keys = require('rewgs-arch.keys.alt')          -- ALT key as main mod
local keys = require('rewgs-arch.keys.tmux')         -- no wezterm tabs/panes, only using tmux
-- local keys = require('rewgs-arch.keys.zellij_keys')  -- no wezterm tabs/panes, only using zellij

function module.apply_to_config(config)
    config.enable_wayland = true
    config.window_decorations = 'NONE'

    appearance.apply_to_config(config)
    font.apply_to_config(config)
    keys.apply_to_config(config)
end
return module
