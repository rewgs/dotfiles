local module = {}

local appearance = require('common.appearance')
local font = require('common.font')
local keys = require('common.keys')
local settings = require('common.settings')


function module.apply_to_config(config)
    appearance.apply_to_config(config)
    font.apply_to_config(config)
    keys.apply_to_config(config)
    settings.apply_to_config(config)
end

return module
