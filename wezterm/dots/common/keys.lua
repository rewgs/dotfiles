-- local wezterm = require('wezterm')

local module = {}

function module.apply_to_config(config)
    config.disable_default_key_bindings = true
end
return module
