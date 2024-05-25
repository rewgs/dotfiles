local wezterm = require('wezterm')
local config = wezterm.config_builder()
local macOS = require('macOS.init')


-- appearance
config.front_end = 'OpenGL'
config.check_for_updates = false
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
if os.execute("uname") == "Linux" then
    config.enable_wayland = true
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

-- elseif os.execute("uname") == "Linux" then
--     config.keys = {
--         -- reloads WezTerm config
--         { key = 'r', mods = 'CTRL|SHIFT', action = wezterm.action.ReloadConfiguration },
--     }
-- end

macOS.apply_to_config(config)
return config
