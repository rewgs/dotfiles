local module = {}

local appearance = require('rewgs-thinkpad-x1.appearance')
local font = require('rewgs-thinkpad-x1.font')

-- local keys = require('rewgs-thinkpad-x1.keys.standard')     -- ALT|CTRL as main mod
-- local keys = require('rewgs-thinkpad-x1.keys.alt')          -- ALT key as main mod
local keys = require('rewgs-thinkpad-x1.keys.tmux')         -- no wezterm tabs/panes, only using tmux
-- local keys = require('rewgs-thinkpad-x1.keys.zellij_keys')  -- no wezterm tabs/panes, only using zellij

function module.apply_to_config(config)
    config.enable_wayland = true
    config.window_decorations = 'NONE'

    appearance.apply_to_config(config)
    font.apply_to_config(config)
    keys.apply_to_config(config)
end
return module
