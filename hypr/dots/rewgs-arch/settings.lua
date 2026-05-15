-- See https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    ecosystem = {
        no_update_news = true,
    },
})

hl.config({
    general = {
        gaps_in    = 5,
        gaps_out   = 10,
        border_size = 3,

        col = {
            active_border   = "rgb(61afef)",
            inactive_border = "rgba(00000000)",
        },

        layout = "dwindle",
        -- layout = "master",
    },
})

hl.config({
    group = {
        auto_group           = false,
        insert_after_current = true,
        focus_removed_window = true,

        col = {
            border_active   = "rgb(61afef)",
            border_inactive = "rgba(00000000)",  -- no border when inactive
        },

        groupbar = {
            enabled  = true,
            stacked  = false,

            indicator_gap    = 0,
            indicator_height = 0,

            keep_upper_gap = false,

            font_family = "FiraCode Nerd Font Retina",
            font_size   = 13,
            height      = 20,

            gradients   = true,
            scrolling   = false,
            text_offset = 0,

            render_titles = true,

            col = {
                active   = "rgb(404452)",
                inactive = "rgba(21252bff)",
            },

            font_weight_active   = "bold",
            font_weight_inactive = "normal",

            text_color          = "rgb(b2b7c1)",
            text_color_inactive = "rgb(abb2bf)",
        },
    },
})

hl.config({
    misc = {
        -- onedark "black"
        -- background_color = "rgb(282C34)",

        -- onedark "black" -- darker
        -- background_color = "rgb(21252b)",

        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },
})
