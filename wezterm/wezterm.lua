-------------------------------------------------------------------------------
-- basics
-------------------------------------------------------------------------------
-- get OS
local os = os.execute('uname')

-- pull in the wezterm API
local wezterm = require 'wezterm'

-- this table will hold the configuration
local config = {}

-- provides clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.front_end = 'WebGpu'

-------------------------------------------------------------------------------
-- window appearance
-------------------------------------------------------------------------------
config.window_decorations = 'RESIZE' -- removes the titlebar but allows the window to remain resizable
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.native_macos_fullscreen_mode = true


-------------------------------------------------------------------------------
-- color scheme
-------------------------------------------------------------------------------
-- config.color_scheme = 'GruvboxDark'
-- config.color_scheme = 'GruvboxDarkHard'
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = 'Gruvbox dark, pale (base16)'
-- config.color_scheme = 'Gruvbox dark, soft (base16)'
-- config.color_scheme = 'Gruvbox Material (Gogh)'
-- config.color_scheme = 'OneDark (base16)'
-- config.color_scheme = 'OneDark (Gogh)'
config.color_scheme = 'OneHalfDark'


-------------------------------------------------------------------------------
-- font
-------------------------------------------------------------------------------
config.font = wezterm.font {
    family = 'FiraCode Nerd Font',
    weight = 'Regular'
    -- family = 'JetBrains Mono'
    -- family = 'Berkeley Mono'
}
config.font_size = 14

-------------------------------------------------------------------------------
-- key bindings
-------------------------------------------------------------------------------
if os == 'Darwin' then
    config.keys = {
        ---------------------------------------------------------------------------
        -- basics
        ---------------------------------------------------------------------------

        -- reloads WezTerm config
        {
            key = 'r',
            mods = 'SUPER|SHIFT',
            action = wezterm.action.ReloadConfiguration,
        },

        ---------------------------------------------------------------------------
        -- disable default assignments
        ---------------------------------------------------------------------------

        -- disables the default SUPER-m hide action, allowing SUPER-m to be recognized and handled by the tab
        {
            key = 'm',
            mods = 'SUPER',
            action = wezterm.action.DisableDefaultAssignment,
        },

        -- disables the default SUPER-w close window action
        {
            key = 'w',
            mods = 'SUPER',
            action = wezterm.action.DisableDefaultAssignment,
        },

        ---------------------------------------------------------------------------
        -- tmux
        ---------------------------------------------------------------------------

        -- tmux: new window (i.e. tab)
        {
            key = 't',
            mods = 'SUPER',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 't' },
            },
        },

        -- tmux: close pane
        {
            key = 'w',
            mods = 'SUPER',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'w' },
            },
        },

        -- tmux: split vertically
        {
            key = '\\',
            mods = 'SUPER',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = '\\' },
            },
        },

        -- tmux: split horizontally
        {
            key = '-',
            mods = 'SUPER',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = '-' },
            },
        },

        -- tmux: navigate left
        {
            key = 'h',
            mods = 'SUPER',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'h' },
            },
        },

        -- tmux: navigate down
        {
            key = 'j',
            mods = 'SUPER',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'j' },
            },
        },

        -- tmux: navigate up
        {
            key = 'k',
            mods = 'SUPER',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'k' },
            },
        },

        -- tmux: navigate right
        {
            key = 'l',
            mods = 'SUPER',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'l' },
            },
        },

        -- tmux: resize left
        {
            key = 'H',
            mods = 'SUPER|SHIFT',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'H' },
            },
        },

        -- tmux: resize down
        {
            key = 'J',
            mods = 'SUPER|SHIFT',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'J' },
            },
        },

        -- tmux: resize up
        {
            key = 'K',
            mods = 'SUPER|SHIFT',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'K' },
            },
        },

        -- tmux: resize right
        {
            key = 'L',
            mods = 'SUPER|SHIFT',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'L' },
            },
        },

        -- tmux: rename session
        {
            key = 'R',
            mods = 'SUPER|SHIFT',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'R' },
            },
        },

        -- tmux: rename window (i.e. tab)
        {
            key = 'r',
            mods = 'SUPER',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'r' },
            },
        },

        -- tmux: select next window (i.e. tab)
        {
            key = 'Tab',
            mods = 'CTRL',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'n' },
            },
        },

        -- tmux: select previous window (i.e. tab)
        {
            key = 'Tab',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'p' },
            },
        },

        -- tmux: save session
        {
            key = 's',
            mods = 'SUPER|CTRL',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 's', mods = 'CTRL' },
            },
        },

        -- tmux: restore session
        {
            key = 'r',
            mods = 'SUPER|CTRL',
            action = wezterm.action.Multiple {
                wezterm.action.SendKey { key = 'p', mods = 'CTRL' },
                wezterm.action.SendKey { key = 'r', mods = 'CTRL' },
            },
        },
    }
end

if os == 'Linux' then
    config.keys = {
        ---------------------------------------------------------------------------
        -- basics
        ---------------------------------------------------------------------------

        -- reloads WezTerm config
        {
            key = 'r',
            mods = 'CTRL|SHIFT',
            action = wezterm.action.ReloadConfiguration,
        },
    }
end

-- returns the config to wezterm
return config
