local wezterm = require('wezterm')
local module = {}

local PREFIX = { key = 'p', mods = 'CTRL' }

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
    zellij = {
        pane = {
            resize = {
                left = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = 'H' })
                },
                down = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = 'J' })
                },
                up = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = 'K' })
                },
                right = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = 'L' })
                },
            },
            select = {
                left = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = 'h' })
                },
                down = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = 'j' })
                },
                up = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = 'k' })
                },
                right = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = 'l' })
                },
            },
            split = {
                horizontal = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = '|' }),
                },
                vertical = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = '_' }),
                },
            },
            swap = {
                clockwise = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = '=', mods = 'ALT' }),
                },
                counter_clockwise = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = '-', mods = 'ALT' }),
                },
            },
        },
        session = {
            detach = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(PREFIX),
                wezterm.action.SendKey({ key = 'd' })
            },
            rename = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(PREFIX),
                wezterm.action.SendKey({ key = 'R' })
            },
            restore = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(PREFIX),
                wezterm.action.SendKey({ key = 'r', mods = 'CTRL' })
            },
            save = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(PREFIX),
                wezterm.action.SendKey({ key = 's', mods = 'CTRL' })
            },
        },
        window = {
            close = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(PREFIX),
                wezterm.action.SendKey({ key = 'w' }),
            },
            new = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(PREFIX),
                wezterm.action.SendKey({ key = 't' }),
            },
            rename = wezterm.action.Multiple {
                wezterm.action.DisableDefaultAssignment,
                wezterm.action.SendKey(PREFIX),
                wezterm.action.SendKey({ key = 'r' }),
            },
            select = {
                next = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = 'n' }),
                },
                previous = wezterm.action.Multiple {
                    wezterm.action.DisableDefaultAssignment,
                    wezterm.action.SendKey(PREFIX),
                    wezterm.action.SendKey({ key = 'p' }),
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
    -- { key = 'v',    mods = 'CTRL|SHIFT',    action = wezterm.action.PasteFrom "Clipboard" },

    ---------------------------------------------------------------------------
    -- tmux
    ---------------------------------------------------------------------------
    -- pane - resize
    { key = 'H',    mods = 'ALT|SHIFT',     action = actions.zellij.pane.resize.left },
    { key = 'J',    mods = 'ALT|SHIFT',     action = actions.zellij.pane.resize.down },
    { key = 'K',    mods = 'ALT|SHIFT',     action = actions.zellij.pane.resize.up },
    { key = 'L',    mods = 'ALT|SHIFT',     action = actions.zellij.pane.resize.right },

    -- pane - select
    { key = 'h',    mods = 'ALT',           action = actions.zellij.pane.select.left },
    { key = 'j',    mods = 'ALT',           action = actions.zellij.pane.select.down },
    { key = 'k',    mods = 'ALT',           action = actions.zellij.pane.select.up },
    { key = 'l',    mods = 'ALT',           action = actions.zellij.pane.select.right },

    -- pane - split
    { key = '|',    mods = 'ALT|SHIFT',     action = actions.zellij.pane.split.horizontal },   -- NOTE: weirdly, SHIFT must be included even if `key` requires SHIFT.
    { key = '_',    mods = 'ALT|SHIFT',     action = actions.zellij.pane.split.vertical },

    -- pane - swap
    -- { key = '=',    mods = 'ALT|CTRL',     action = actions.zellij.pane.swap.clockwise },
    -- { key = '-',    mods = 'ALT|CTRL',     action = actions.zellij.pane.swap.counter_clockwise },

    -- session
    { key = 'd',    mods = 'ALT',           action = actions.zellij.session.detach },
    { key = 'R',    mods = 'ALT|SHIFT',     action = actions.zellij.session.rename },
    { key = 'S',    mods = 'ALT|SHIFT',     action = actions.zellij.session.restore },
    { key = 's',    mods = 'ALT',           action = actions.zellij.session.save },

    -- window
    { key = 'w',    mods = 'ALT',           action = actions.zellij.window.close },
    { key = 'r',    mods = 'ALT',           action = actions.zellij.window.rename },
    { key = 't',    mods = 'ALT',           action = actions.zellij.window.new },
    { key = 'Tab',  mods = 'CTRL',          action = actions.zellij.window.select.next },
    { key = 'Tab',  mods = 'CTRL|SHIFT',    action = actions.zellij.window.select.previous },
}

function module.apply_to_config(config)
    config.keys = keys
end
return module
