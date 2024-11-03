local module = {}

local appearance = require('rewgs-nas-win11-vm.appearance')
local font = require('rewgs-nas-win11-vm.font')
local keys = require('rewgs-nas-win11-vm.keys.standard')

function module.apply_to_config(config)
    config.prefer_egl = true
    config.default_prog = { 'pwsh.exe' }

    appearance.apply_to_config(config)
    font.apply_to_config(config)
    keys.apply_to_config(config)
end

return module
