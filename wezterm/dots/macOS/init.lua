local module = {}
local keys = require('macOS.keys')


function module.apply_to_config(config)
    keys.apply_to_config(config)
end
return module
