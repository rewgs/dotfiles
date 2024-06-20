local wezterm = require('wezterm')
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
    scrollbar_thumb = user_scheme.black,
    split           = user_scheme.black,

    ansi = {
        -- 'black',
        -- 'maroon',
        -- 'green',
        -- 'olive',
        -- 'navy',
        -- 'purple',
        -- 'teal',
        -- 'silver',

        user_scheme.black,
        user_scheme.dark_red,
        user_scheme.green,
        user_scheme.light_yellow,
        user_scheme.blue,
        user_scheme.magenta,
        user_scheme.cyan,
        user_scheme.white,
    },
    brights = {
        -- 'grey',
        -- 'red',
        -- 'lime',
        -- 'yellow',
        -- 'blue',
        -- 'fuchsia',
        -- 'aqua',
        -- 'white',

        user_scheme.gutter_grey,
        user_scheme.light_red,
        user_scheme.green,
        user_scheme.dark_yellow,
        user_scheme.blue,
        user_scheme.light_red,
        user_scheme.blue,
        user_scheme.comment_grey,
    },
}

function module.apply_to_config(config)
    -- basics
    config.front_end = 'OpenGL'

    -- colors
    config.color_scheme = stock_scheme
    -- config.colors = user_colors

    -- tab bar
    config.enable_tab_bar = true
    config.hide_tab_bar_if_only_one_tab = true
    config.show_tab_index_in_tab_bar = false
    config.tab_and_split_indices_are_zero_based = true
    config.use_fancy_tab_bar = true
end


return module
