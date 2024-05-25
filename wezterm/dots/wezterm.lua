local wezterm = require('wezterm')
local config = wezterm.config_builder()


-- appearance
config.front_end = 'OpenGL'
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
if os.execute("uname") == "Linux" then
    config.enable_wayland = true
end
if os.execute("uname") == "Darwin" then
    config.native_macos_fullscreen_mode = true
end


-- color scheme
config.color_scheme = 'OneHalfDark'


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
    local linux_config = require('linux.init')
    linux_config.apply_to_config(config)
    return config
end

if is_macOS() then
    local macOS_config = require('macOS.init')
    macOS_config.apply_to_config(config)
    return config
end
