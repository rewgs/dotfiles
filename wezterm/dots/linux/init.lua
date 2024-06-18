local module = {}

local keys = require('linux.keys')

function module.apply_to_config(config)
    config.enable_wayland = true

    keys.apply_to_config(config)
end
return module
