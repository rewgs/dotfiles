local wezterm = require('wezterm')

local module = {}

function module.apply_to_config(config)
    config.font_size = 12
    config.font = wezterm.font_with_fallback {
        { family = 'FiraCode NF',    weight = 'Regular' },
        { family = 'Berkeley Mono',  weight = 'Regular' },
        { family = 'JetBrains Mono', weight = 'Regular' },
    }
end

return module
