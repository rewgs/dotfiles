-- local wezterm = require('wezterm')

local module = {}

function module.apply_to_config(config)
    config.check_for_updates = false
end
return module
