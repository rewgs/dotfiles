local wezterm = require('wezterm')

local module = {}

function module.apply_to_config(config)
    config.font_size = 14
    config.font = wezterm.font_with_fallback {
        -- macOS
        { family = 'FiraCode Nerd Font', weight = 'Regular' },
        { family = 'SF Mono', weight = 'Regular' },
        { family = 'Monaco', weight = 'Regular' },

        -- ...another OS
        -- NOTE: I seem to remember that FiraCode Nerd Font is always spelled differently on Windows
        { family = 'FiraCode Nerd Font Mono', weight = 'Regular' },

        -- fallbacks
        { family = 'Berkeley Mono', weight = 'Regular' },
        { family = 'JetBrains Mono', weight = 'Regular' },
    }
end
return module
