local module = {}
local keys = require('linux.keys')

function module.apply_to_config(config)
    keys.apply_to_config(config)
end
return module
