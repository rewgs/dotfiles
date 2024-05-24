local wezterm = require('wezterm')
local module = {}

local keys = {
    -- reloads WezTerm config
    { key = 'r', mods = 'SUPER|SHIFT', action = wezterm.action.ReloadConfiguration },

    -- disables the default SUPER-m hide action, allowing SUPER-m to be recognized and handled by the tab
    { key = 'm', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },

    -- disables the default SUPER-w close window action
    { key = 'w', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },

    -- disables the default SUPER-t close tab action
    { key = 't', mods = 'SUPER', action = wezterm.action.DisableDefaultAssignment },

    -- tmux: new window (i.e. tab)
    { key = 't', mods = 'SUPER', action = wezterm.action.Multiple {
                                    wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                    wezterm.action.SendKey { key = 't' } } },
    -- tmux: close pane
    { key = 'w', mods = 'SUPER', action = wezterm.action.Multiple {
                                    wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                    wezterm.action.SendKey { key = 'w' } } },
    -- tmux: split vertically
    { key = '\\', mods = 'SUPER', action = wezterm.action.Multiple {
                                    wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                    wezterm.action.SendKey { key = '\\' } } },

    -- tmux: split horizontally
    { key = '-', mods = 'SUPER', action = wezterm.action.Multiple {
                                    wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                    wezterm.action.SendKey { key = '-' } } },
    -- tmux: navigate left
    { key = 'h', mods = 'SUPER', action = wezterm.action.Multiple {
                                    wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                    wezterm.action.SendKey { key = 'h' } } },
    -- tmux: navigate down
    { key = 'j', mods = 'SUPER', action = wezterm.action.Multiple {
                                    wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                    wezterm.action.SendKey { key = 'j' } } },
    -- tmux: navigate up
    { key = 'k', mods = 'SUPER', action = wezterm.action.Multiple {
                                    wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                    wezterm.action.SendKey { key = 'k' } } },
    -- tmux: navigate right
    { key = 'l', mods = 'SUPER', action = wezterm.action.Multiple {
                                    wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                    wezterm.action.SendKey { key = 'l' } } },
    -- tmux: resize left
    { key = 'h', mods = 'SUPER|SHIFT', action = wezterm.action.Multiple {
                                        wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                        wezterm.action.SendKey { key = 'H' } } },
    -- tmux: resize down
    { key = 'j', mods = 'SUPER|SHIFT', action = wezterm.action.Multiple {
                                        wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                        wezterm.action.SendKey { key = 'J' } } },
    -- tmux: resize up
    { key = 'k', mods = 'SUPER|SHIFT', action = wezterm.action.Multiple {
                                        wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                        wezterm.action.SendKey { key = 'K' } } },
    -- tmux: resize right
    { key = 'l', mods = 'SUPER|SHIFT', action = wezterm.action.Multiple {
                                        wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                        wezterm.action.SendKey { key = 'L' } } },
    -- tmux: rename session
    { key = 'r', mods = 'SUPER|SHIFT', action = wezterm.action.Multiple {
                                        wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                        wezterm.action.SendKey { key = 'R' } } },
    -- tmux: rename window (i.e. tab)
    { key = 'r', mods = 'SUPER', action = wezterm.action.Multiple {
                                    wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                    wezterm.action.SendKey { key = 'r' } } },
    -- tmux: select next window (i.e. tab)
    { key = 'Tab', mods = 'CTRL', action = wezterm.action.Multiple {
                                    wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                    wezterm.action.SendKey { key = 'n' } } },
    -- tmux: select previous window (i.e. tab)
    { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.Multiple {
                                        wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                        wezterm.action.SendKey { key = 'p' } } },
    -- tmux: save session
    { key = 's', mods = 'SUPER|CTRL', action = wezterm.action.Multiple {
                                        wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                        wezterm.action.SendKey { key = 's', mods = 'CTRL' } } },
    -- tmux: restore session
    { key = 'r', mods = 'SUPER|CTRL', action = wezterm.action.Multiple {
                                        wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                                        wezterm.action.SendKey { key = 'r', mods = 'CTRL' } } }
}

function module.apply_to_config(config)
    config.keys = keys
end
return module
