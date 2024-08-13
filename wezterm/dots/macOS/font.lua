local wezterm = require('wezterm')

local module = {}

function module.apply_to_config(config)
    -- config.font_size = 15
    config.font_size = 16
    config.font = wezterm.font_with_fallback {
        { family = 'FiraCode Nerd Font', weight = 'Regular' },

        -- fallbacks
        { family = 'Berkeley Mono', weight = 'Regular' },
        { family = 'JetBrains Mono', weight = 'Regular' },
    }
end
return module
