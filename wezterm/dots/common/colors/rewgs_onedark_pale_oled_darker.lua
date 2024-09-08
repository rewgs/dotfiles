-- Colors with three entries were causing conflicts, so "light" was copied to just the base color; "dark" is not used (for now).
local onedark = {
    white           = "#89909d",

    -- black           = "#27282c", -- actual "black" for this color scheme, buuuuut...
    black           = "#000000", -- going with pure black for oled usage

    light_red       = "#aa5A62",
    dark_red        = "#9a555b",
    green           = "#789266",
    light_yellow    = "#af9564",
    dark_yellow     = "#a58b59",

    -- blues: light to dark
    -- blue            = "#ffffff", -- test...why isn't this changing?
    blue            = "#79b3e2",
    -- blue            = "#5489b4",
    -- blue            = "#4f7ea4",

    magenta         = "#8d5a9c",
    cyan            = "#52787d",
    comment_grey    = "#89909d",
    gutter_grey     = "#89909d",
}

return onedark
