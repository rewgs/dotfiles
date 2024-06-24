-- Colors with three entries were causing conflicts, so "light" was copied to just the base color; "dark" is not used (for now).
local onedark = {
    white           = "#ABB2BF", -- original onedark grey
    -- white           = "#ffffff", -- standard white is just too bright, needs lower contrast

    black           = "#000000",
    -- light_black     = "#343841",
    -- dark_black      = "#2B2D32",

    light_red       = "#D77F87",
    dark_red        = "B8565E",

    -- green           = "#A8C097", -- new hue, adjusted for oled -- lighter
    green           = "#81A273", -- new hue, adjusted for oled -- darker
    -- green           = "#9FBF89", -- from rewgs onedark pale
    -- light_green     = "#9FBF89",
    -- dark_green      = "#7C9F63",

    light_yellow    = "#DCC18D",
    dark_yellow     = "#BE9D60",

    blue            = "#79B3E2",
    -- light_blue      = "#79B3E2",
    -- dark_blue       = "#4D8FC5",

    magenta         = "#C48AD6",
    -- light_magenta   = "#C48AD6",
    -- dark_magenta    = "#A35FB7",

    cyan            = "#6BB2BB",
    -- light_cyan      = "#6BB2BB",
    -- dark_cyan       = "#538F97",

    comment_grey	    = "#B2B7C1",
    gutter_grey       = "#89909D",
    -- light_grey	    = "#B2B7C1",
    -- dark_grey       = "#89909D",
}

return onedark
