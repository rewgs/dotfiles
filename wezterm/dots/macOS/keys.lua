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
    -- multiplexing
    ---------------------------------------------------------------------------
    -- TODO: Maybe use SplitPane() instead? https://wezfurlong.org/wezterm/config/lua/keyassignment/SplitPane.html
    { key = '|',    mods = 'SUPER|SHIFT',   action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-',    mods = 'SUPER|SHIFT',   action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 'h',    mods = 'SUPER',         action = wezterm.action.ActivatePaneDirection 'Left', },
    { key = 'j',    mods = 'SUPER',         action = wezterm.action.ActivatePaneDirection 'Down', },
    { key = 'k',    mods = 'SUPER',         action = wezterm.action.ActivatePaneDirection 'Up', },
    { key = 'l',    mods = 'SUPER',         action = wezterm.action.ActivatePaneDirection 'Right', },

    -- Closes the current pane. 
    -- If that was the last pane in the tab, closes the tab. If that was the last tab, closes that 
    -- window. If that was the last window, wezterm terminates. The act of closing a pane shuts down 
    -- the PTY associated with the pane and then kills the process associated with that pane. When 
    -- confirm is true, an overlay will render over the pane to ask you to confirm whether you want 
    -- to close it. See also skip_close_confirmation_for_processes_named. If confirm is false, then 
    -- this action will immediately close the pane without prompting.
    { key = 'w',    mods = 'SUPER',         action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}

function module.apply_to_config(config)
    config.keys = keys
end
return module
