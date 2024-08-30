local module = {}

local font = require('macOS.font')
local keys = require('macOS.keys')
-- local keys = require('macOS.tmux_keys')

function module.apply_to_config(config)
    -- The latter vastly helps overall system graphics performance.
    -- Source: https://github.com/wez/wezterm/issues/2669
    config.window_decorations = 'RESIZE|MACOS_FORCE_DISABLE_SHADOW'

    config.native_macos_fullscreen_mode = true
    config.quit_when_all_windows_are_closed = false

    font.apply_to_config(config)
    keys.apply_to_config(config)
end
return module
