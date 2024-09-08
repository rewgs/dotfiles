local module = {}

local appearance = require('rewgs-2021-macbook-air.appearance')
local keys = require('rewgs-2021-macbook-air.keys')

function module.apply_to_config(config)
    config.window_decorations = 'RESIZE'
    config.native_macos_fullscreen_mode = false
    config.quit_when_all_windows_are_closed = false

    appearance.apply_to_config(config)
    keys.apply_to_config(config)
end
return module
