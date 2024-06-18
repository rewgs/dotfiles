local module = {}

local keys = require('macOS.keys')
-- local keys = require('macOS.tmux_keys')

function module.apply_to_config(config)
    config.window_decorations = "RESIZE"
    config.native_macos_fullscreen_mode = false

    keys.apply_to_config(config)
end
return module
