-- local wezterm = require('wezterm')
local module = {}

local stock_scheme = "OneHalfDark"
local user_scheme = require('common.colors.onedark')
local user_colors = {
    foreground      = user_scheme.white,
    background      = user_scheme.black,
    cursor_bg       = user_scheme.white,
    cursor_fg       = user_scheme.black,
    cursor_border   = user_scheme.white,
    selection_fg    = user_scheme.black,
    selection_bg    = user_scheme.white,
    split           = user_scheme.black,
}

function module.apply_to_config(config)
    -- basics
    config.front_end = 'OpenGL'

    -- colors
    config.color_scheme = stock_scheme
    config.colors = user_colors

    -- tab bar
    config.enable_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = true
end
return module


