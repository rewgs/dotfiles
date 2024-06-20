local module = {}

local keys = require('macOS.keys')
-- local keys = require('macOS.tmux_keys')

function module.apply_to_config(config)
    config.native_macos_fullscreen_mode = false
    config.quit_when_all_windows_are_closed = false

    keys.apply_to_config(config)
end
return module
