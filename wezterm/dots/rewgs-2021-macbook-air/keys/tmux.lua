local wezterm = require('wezterm')
local module = {}

local TMUX_PREFIX = { key = 'p', mods = 'CTRL' }

local actions = {
    meta = {
        -- close_tab = wezterm.action.Multiple {
        --     wezterm.action.DisableDefaultAssignment,
        --     wezterm.action.CloseCurrentTab
        -- },
        reload_config = wezterm.action.Multiple {
            wezterm.action.DisableDefaultAssignment,
            wezterm.action.ReloadConfiguration
        },
        toggle_fullscreen = wezterm.action.Multiple {
            wezterm.action.DisableDefaultAssignment,
            wezterm.action.ToggleFullScreen
        },
    },
    tmux = {
        pane = {
            resize = {
                left = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = 'H' })
                },
                down = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = 'J' })
                },
                up = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = 'K' })
                },
                right = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = 'L' })
                },
            },
            select = {
                left = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = 'h' })
                },
                down = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = 'j' })
                },
                up = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = 'k' })
                },
                right = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = 'l' })
                },
            },
            split = {
                horizontal = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = '|' }),
                },
                vertical = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = '_' }),
                },
            },
            swap = {
                clockwise = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = '=', mods = 'ALT' }),
                },
                counter_clockwise = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = '-', mods = 'ALT' }),
                },
            },
        },
        session = {
            overview = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(TMUX_PREFIX),
                wezterm.action.SendKey({ key = 'o' })
            },
            rename = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(TMUX_PREFIX),
                wezterm.action.SendKey({ key = 'R' })
            },
            restore = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(TMUX_PREFIX),
                wezterm.action.SendKey({ key = 'r', mods = 'CTRL' })
            },
            save = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(TMUX_PREFIX),
                wezterm.action.SendKey({ key = 's', mods = 'CTRL' })
            },
        },
        window = {
            close = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(TMUX_PREFIX),
                wezterm.action.SendKey({ key = 'w' }),
            },
            new = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(TMUX_PREFIX),
                wezterm.action.SendKey({ key = 't' }),
            },
            rename = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(TMUX_PREFIX),
                wezterm.action.SendKey({ key = 'r' }),
            },
            select = {
                next = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = '=' }),
                },
                previous = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(TMUX_PREFIX),
                    wezterm.action.SendKey({ key = '-' }),
                },
            },
        },
    },
}

local keys = {
    ---------------------------------------------------------------------------
    -- disabled
    ---------------------------------------------------------------------------
    { key = '-',    mods = 'CMD',         action = wezterm.action.DisableDefaultAssignment },
    { key = '-',    mods = 'CMD|SHIFT',   action = wezterm.action.DisableDefaultAssignment },
    { key = '=',    mods = 'CMD',         action = wezterm.action.DisableDefaultAssignment },
    { key = '=',    mods = 'CMD|SHIFT',   action = wezterm.action.DisableDefaultAssignment },
    { key = '\\',   mods = 'CMD',         action = wezterm.action.DisableDefaultAssignment },
    { key = '\\',   mods = 'CMD|SHIFT',   action = wezterm.action.DisableDefaultAssignment },
    { key = 'p',    mods = 'CMD',         action = wezterm.action.DisableDefaultAssignment },
    { key = 'h',    mods = 'CMD',         action = wezterm.action.DisableDefaultAssignment },
    { key = 'j',    mods = 'CMD',         action = wezterm.action.DisableDefaultAssignment },
    { key = 'k',    mods = 'CMD',         action = wezterm.action.DisableDefaultAssignment },
    { key = 'l',    mods = 'CMD',         action = wezterm.action.DisableDefaultAssignment },

    ---------------------------------------------------------------------------
    -- meta
    ---------------------------------------------------------------------------
    { key = 'r',    mods = 'CMD',           action = actions.meta.reload_config },
    { key = 'f',    mods = 'CMD',         action = actions.meta.toggle_fullscreen },

    ---------------------------------------------------------------------------
    -- clipboard
    ---------------------------------------------------------------------------
    { key = 'c',    mods = 'CMD',    action = wezterm.action.CopyTo "ClipboardAndPrimarySelection" },
    { key = 'v',    mods = 'CMD',    action = wezterm.action.PasteFrom "PrimarySelection" },
    { key = 'v',    mods = 'CMD',    action = wezterm.action.PasteFrom "Clipboard" },

    ---------------------------------------------------------------------------
    -- tmux
    ---------------------------------------------------------------------------
    -- pane - resize
    { key = 'H',    mods = 'CMD|SHIFT',     action = actions.tmux.pane.resize.left },
    { key = 'J',    mods = 'CMD|SHIFT',     action = actions.tmux.pane.resize.down },
    { key = 'K',    mods = 'CMD|SHIFT',     action = actions.tmux.pane.resize.up },
    { key = 'L',    mods = 'CMD|SHIFT',     action = actions.tmux.pane.resize.right },

    -- pane - select
    { key = 'h',    mods = 'CMD',           action = actions.tmux.pane.select.left },
    { key = 'j',    mods = 'CMD',           action = actions.tmux.pane.select.down },
    { key = 'k',    mods = 'CMD',           action = actions.tmux.pane.select.up },
    { key = 'l',    mods = 'CMD',           action = actions.tmux.pane.select.right },

    -- pane - split
    { key = '|',    mods = 'CMD|SHIFT',     action = actions.tmux.pane.split.horizontal },   -- NOTE: weirdly, SHIFT must be included even if `key` requires SHIFT.
    { key = '_',    mods = 'CMD|SHIFT',     action = actions.tmux.pane.split.vertical },

    -- pane - swap
    -- { key = '=',    mods = 'ALT|CTRL',     action = actions.tmux.pane.swap.clockwise },
    -- { key = '-',    mods = 'ALT|CTRL',     action = actions.tmux.pane.swap.counter_clockwise },

    -- session
    { key = 'o',    mods = 'CMD',           action = actions.tmux.session.overview },
    { key = 'R',    mods = 'CMD|SHIFT',     action = actions.tmux.session.rename },
    { key = 'S',    mods = 'CMD|SHIFT',     action = actions.tmux.session.restore },
    { key = 's',    mods = 'CMD',           action = actions.tmux.session.save },

    -- window
    { key = 'w',    mods = 'CMD',           action = actions.tmux.window.close },
    { key = 'r',    mods = 'CMD',           action = actions.tmux.window.rename },
    { key = 't',    mods = 'CMD',           action = actions.tmux.window.new },
    { key = 'Tab',  mods = 'CTRL',          action = actions.tmux.window.select.next },
    { key = 'Tab',  mods = 'CTRL|SHIFT',    action = actions.tmux.window.select.previous },
}

function module.apply_to_config(config)
    config.keys = keys
end
return module
