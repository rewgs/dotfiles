-- local wezterm = require('wezterm')

local module = {}

local scheme = require('colors.onedark')

local colors = {
    foreground      = scheme.white,
    background      = scheme.black,
    cursor_bg       = scheme.white,
    cursor_fg       = scheme.black,
    cursor_border   = scheme.white,
    selection_fg    = scheme.black,
    selection_bg    = scheme.white,
    split           = scheme.black,
}

function module.apply_to_config(config)
    config.color_scheme = 'OneHalfDark'

    config.colors = colors
end
return module
