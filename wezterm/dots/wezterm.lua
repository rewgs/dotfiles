local wezterm = require('wezterm')
local config = wezterm.config_builder()


-- appearance
config.front_end = 'OpenGL'
config.enable_tab_bar = false

if os.execute("uname") == "Linux" then
    config.enable_wayland = true
end
if os.execute("uname") == "Darwin" then
    config.window_decorations = "RESIZE"
    config.native_macos_fullscreen_mode = true
end


-- color scheme
config.color_scheme = 'OneHalfDark'
local onedark = {
    black           = "#282c34",
    white           = "#abb2bf",
    light_red       = "#e06c75",
    dark_red        = "#be5046",
    light_yellow    = "#e5c07b",
    dark_yellow	    = "#d19a66",
    blue            = "#61afef",
    magenta         = "#c678dd",
    cyan            = "#56b6c2",
    gutter_grey	    = "#4b5263",
    comment_grey    = "#5c6370",
}
config.colors = {
    foreground = onedark.white,
    background = onedark.black,
    cursor_bg = onedark.white,
    cursor_fg = onedark.black,
    cursor_border = onedark.white,
    selection_fg = onedark.black,
    selection_bg = onedark.white,
    split = onedark.black,
}


-- font
config.font_size = 14
config.font = wezterm.font {
    -- family = 'Berkeley Mono',
    family = 'FiraCode Nerd Font',
    -- family = 'JetBrains Mono',
    weight = 'Regular'
}


-- misc
config.check_for_updates = false


-------------------------------------------------------------------------------
-- load OS-specific files
-------------------------------------------------------------------------------

local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

local is_macOS = function()
	return wezterm.target_triple:find("darwin") ~= nil
end


if is_linux() then
    -- local linux_config = require('linux.init')
    -- linux_config.apply_to_config(config)
    return config
end

if is_macOS() then
    local macOS_config = require('macOS.init')
    macOS_config.apply_to_config(config)
    return config
end
