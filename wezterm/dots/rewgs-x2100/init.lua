local module = {}

local appearance = require('rewgs-x2100.appearance')
local font = require('rewgs-x2100.font')

local keys = require('rewgs-x2100.keys.tmux')         -- no wezterm tabs/panes, only using tmux

function module.apply_to_config(config)
    config.enable_wayland = true
    config.window_decorations = 'NONE'

    appearance.apply_to_config(config)
    font.apply_to_config(config)
    keys.apply_to_config(config)
end
return module
