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
            -- FIXME: Why is this not working?!?!?!? It was literally fucking 
            -- working two seconds ago, and now it just executes a blank command.
            -- God I fucking hate computers sometimes.
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
    { key = '-',    mods = 'ALT',         action = wezterm.action.DisableDefaultAssignment },
    { key = '-',    mods = 'ALT|SHIFT',   action = wezterm.action.DisableDefaultAssignment },
    { key = '=',    mods = 'ALT',         action = wezterm.action.DisableDefaultAssignment },
    { key = '=',    mods = 'ALT|SHIFT',   action = wezterm.action.DisableDefaultAssignment },
    { key = '\\',   mods = 'ALT',         action = wezterm.action.DisableDefaultAssignment },
    { key = '\\',   mods = 'ALT|SHIFT',   action = wezterm.action.DisableDefaultAssignment },
    { key = 'p',    mods = 'ALT',         action = wezterm.action.DisableDefaultAssignment },
    { key = 'h',    mods = 'ALT',         action = wezterm.action.DisableDefaultAssignment },
    { key = 'j',    mods = 'ALT',         action = wezterm.action.DisableDefaultAssignment },
    { key = 'k',    mods = 'ALT',         action = wezterm.action.DisableDefaultAssignment },
    { key = 'l',    mods = 'ALT',         action = wezterm.action.DisableDefaultAssignment },

    ---------------------------------------------------------------------------
    -- meta
    ---------------------------------------------------------------------------
    -- { key = 'w',    mods = HYPER,           action = actions.meta.close_tab },
    -- { key = 'w',    mods = LEADER,          action = actions.meta.close_tab },
    { key = 'r',    mods = 'ALT',           action = actions.meta.reload_config },
    { key = 'f',    mods = 'ALT',         action = actions.meta.toggle_fullscreen },

    ---------------------------------------------------------------------------
    -- clipboard
    ---------------------------------------------------------------------------
    { key = 'c',    mods = 'CTRL|SHIFT',    action = wezterm.action.CopyTo "ClipboardAndPrimarySelection" },
    { key = 'v',    mods = 'CTRL|SHIFT',    action = wezterm.action.PasteFrom "PrimarySelection" },
    { key = 'v',    mods = 'CTRL|SHIFT',    action = wezterm.action.PasteFrom "Clipboard" },

    ---------------------------------------------------------------------------
    -- tmux
    ---------------------------------------------------------------------------
    -- pane - resize
    { key = 'H',    mods = 'ALT|SHIFT',     action = actions.tmux.pane.resize.left },
    { key = 'J',    mods = 'ALT|SHIFT',     action = actions.tmux.pane.resize.down },
    { key = 'K',    mods = 'ALT|SHIFT',     action = actions.tmux.pane.resize.up },
    { key = 'L',    mods = 'ALT|SHIFT',     action = actions.tmux.pane.resize.right },

    -- pane - select
    { key = 'h',    mods = 'ALT',           action = actions.tmux.pane.select.left },
    { key = 'j',    mods = 'ALT',           action = actions.tmux.pane.select.down },
    { key = 'k',    mods = 'ALT',           action = actions.tmux.pane.select.up },
    { key = 'l',    mods = 'ALT',           action = actions.tmux.pane.select.right },

    -- pane - split
    { key = '|',    mods = 'ALT|SHIFT',     action = actions.tmux.pane.split.horizontal },   -- NOTE: weirdly, SHIFT must be included even if `key` requires SHIFT.
    { key = '_',    mods = 'ALT|SHIFT',     action = actions.tmux.pane.split.vertical },

    -- pane - swap
    -- { key = '=',    mods = 'ALT|CTRL',     action = actions.tmux.pane.swap.clockwise },
    -- { key = '-',    mods = 'ALT|CTRL',     action = actions.tmux.pane.swap.counter_clockwise },

    -- session
    { key = 'o',    mods = 'ALT',           action = actions.tmux.session.overview },
    { key = 'R',    mods = 'ALT|SHIFT',     action = actions.tmux.session.rename },
    { key = 'S',    mods = 'ALT|SHIFT',     action = actions.tmux.session.restore },
    { key = 's',    mods = 'ALT',           action = actions.tmux.session.save },

    -- window
    { key = 'w',    mods = 'ALT',           action = actions.tmux.window.close },
    { key = 'r',    mods = 'ALT',           action = actions.tmux.window.rename },
    { key = 't',    mods = 'ALT',           action = actions.tmux.window.new },
    { key = 'Tab',  mods = 'CTRL',          action = actions.tmux.window.select.next },
    { key = 'Tab',  mods = 'CTRL|SHIFT',    action = actions.tmux.window.select.previous },
}

function module.apply_to_config(config)
    config.keys = keys
end
return module
