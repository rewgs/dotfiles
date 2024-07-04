local module = {}

local font = require('macOS.font')
local keys = require('macOS.keys')
-- local keys = require('macOS.tmux_keys')

function module.apply_to_config(config)
    config.window_decorations = 'RESIZE'
    config.native_macos_fullscreen_mode = false
    config.quit_when_all_windows_are_closed = false

    font.apply_to_config(config)
    keys.apply_to_config(config)
end
return module
