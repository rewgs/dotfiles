local module = {}

local font = require('windows.font')
local keys = require('windows.keys')

function module.apply_to_config(config)
    config.default_prog = {
        'C:\\Program Files\\PowerShell\\7\\pwsh.exe'
    }
    config.window_decorations = 'TITLE|RESIZE'

    font.apply_to_config(config)
    keys.apply_to_config(config)
end
return module
