-- Colors with three entries were causing conflicts, so "light" was copied to just the base color; "dark" is not used (for now).
local rewgs_dark = {
    -- TODO: white needs to be lighter
    white           = "#9f9b9a", -- same as gutter_grey
    black           = "#000000",
    light_red       = "#d64849",
    dark_red        = "#d64849", -- same as light red
    green           = "#93c27b",
    light_yellow    = "#dead4e",
    dark_yellow     = "#9f9b9a", -- i.e. orange
    blue            = "#539abc",
    magenta         = "#bc6db2",
    cyan            = "#5faa96",
    comment_grey    = "#282828", -- darker
    gutter_grey     = "#9f9b9a", -- lighter
}

return rewgs_dark
