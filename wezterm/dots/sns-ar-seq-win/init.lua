local module = {}

local appearance = require('sns-ar-seq-win.appearance')
local font = require('sns-ar-seq-win.font')

local keys = require('sns-ar-seq-win.keys.standard')

function module.apply_to_config(config)
    config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe" }
    config.window_decorations = 'NONE|RESIZE'

    appearance.apply_to_config(config)
    font.apply_to_config(config)
    keys.apply_to_config(config)
end

return module
