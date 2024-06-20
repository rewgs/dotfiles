local module = {}

local keys = require('linux.keys')

function module.apply_to_config(config)
    config.enable_wayland = true
    config.window_decorations = 'NONE'

    keys.apply_to_config(config)
end
return module
