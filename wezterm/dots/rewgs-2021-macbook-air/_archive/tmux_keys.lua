local wezterm = require('wezterm')
local module = {}

local HYPER = 'SUPER|CTRL'
local TMUX_PREFIX = { key = 'p', mods = 'CTRL' }
-- config.leader = { key = 't', mods = 'SUPER|CTRL', timeout_milliseconds = 1000 }

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
    { key = '-',    mods = 'SUPER',         action = wezterm.action.DisableDefaultAssignment },
    { key = '-',    mods = 'SUPER|SHIFT',   action = wezterm.action.DisableDefaultAssignment },
    { key = '=',    mods = 'SUPER',         action = wezterm.action.DisableDefaultAssignment },
    { key = '=',    mods = 'SUPER|SHIFT',   action = wezterm.action.DisableDefaultAssignment },
    { key = '\\',   mods = 'SUPER',         action = wezterm.action.DisableDefaultAssignment },
    { key = '\\',   mods = 'SUPER|SHIFT',   action = wezterm.action.DisableDefaultAssignment },
    { key = 'p',    mods = 'SUPER',         action = wezterm.action.DisableDefaultAssignment },

    ---------------------------------------------------------------------------
    -- meta
    ---------------------------------------------------------------------------
    -- { key = 'w',    mods = HYPER,           action = actions.meta.close_tab },
    -- { key = 'w',    mods = LEADER,          action = actions.meta.close_tab },
    { key = 'r',    mods = HYPER,           action = actions.meta.reload_config },
    { key = 'f',    mods = 'SUPER',         action = actions.meta.toggle_fullscreen },

    ---------------------------------------------------------------------------
    -- tmux
    ---------------------------------------------------------------------------
    -- pane - resize
    { key = 'H',    mods = 'SUPER|SHIFT',   action = actions.tmux.pane.resize.left },
    { key = 'J',    mods = 'SUPER|SHIFT',   action = actions.tmux.pane.resize.down },
    { key = 'K',    mods = 'SUPER|SHIFT',   action = actions.tmux.pane.resize.up },
    { key = 'L',    mods = 'SUPER|SHIFT',   action = actions.tmux.pane.resize.right },

    -- pane - select
    { key = 'h',    mods = 'SUPER',         action = actions.tmux.pane.select.left },
    { key = 'j',    mods = 'SUPER',         action = actions.tmux.pane.select.down },
    { key = 'k',    mods = 'SUPER',         action = actions.tmux.pane.select.up },
    { key = 'l',    mods = 'SUPER',         action = actions.tmux.pane.select.right },

    -- pane - split
    { key = '|',    mods = 'SUPER|SHIFT',   action = actions.tmux.pane.split.horizontal },   -- NOTE: weirdly, SHIFT must be included even if `key` requires SHIFT.
    { key = '_',    mods = 'SUPER|SHIFT',   action = actions.tmux.pane.split.vertical },

    -- pane - swap
    { key = '=',    mods = 'SUPER|ALT',     action = actions.tmux.pane.swap.clockwise },
    { key = '-',    mods = 'SUPER|ALT',     action = actions.tmux.pane.swap.counter_clockwise },

    -- session
    { key = 'R',    mods = 'SUPER|SHIFT',   action = actions.tmux.session.rename },
    { key = 'S',    mods = 'SUPER|SHIFT',   action = actions.tmux.session.restore },
    { key = 's',    mods = 'SUPER',         action = actions.tmux.session.save },

    -- window
    { key = 'w',    mods = 'SUPER',         action = actions.tmux.window.close },
    { key = 'r',    mods = 'SUPER',         action = actions.tmux.window.rename },
    { key = 't',    mods = 'SUPER',         action = actions.tmux.window.new },
    { key = 'Tab',  mods = 'CTRL',          action = actions.tmux.window.select.next }, 
    { key = 'Tab',  mods = 'CTRL|SHIFT',    action = actions.tmux.window.select.previous }, 
}

function module.apply_to_config(config)
    config.keys = keys
end
return module
