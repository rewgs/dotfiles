local wezterm = require('wezterm')

local module = {}

function module.apply_to_config(config)
    config.font_size = 10
    config.font = wezterm.font {
        -- family = 'Berkeley Mono',
        family = 'FiraCode NerdFont',
        -- family = 'JetBrains Mono',

        weight = 'Regular'
    }
end

return module
