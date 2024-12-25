local module = {}

local appearance = require('rewgs-2021-macbook-air.appearance')
local font = require('rewgs-2021-macbook-air.font')

local keys = require('rewgs-2021-macbook-air.keys.standard')
-- local keys = require('rewgs-2021-macbook-air.keys.tmux')

function module.apply_to_config(config)
    -- The latter vastly helps overall system graphics performance.
    -- Source: https://github.com/wez/wezterm/issues/2669
    config.window_decorations = 'RESIZE|MACOS_FORCE_DISABLE_SHADOW'

    config.native_macos_fullscreen_mode = false
    config.quit_when_all_windows_are_closed = false

    appearance.apply_to_config(config)
    font.apply_to_config(config)

    keys.apply_to_config(config)
end

return module
