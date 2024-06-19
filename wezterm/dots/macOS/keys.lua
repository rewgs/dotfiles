local wezterm = require('wezterm')

local module = {}


local HYPER = 'SUPER|CTRL'
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
    -- meta
    ---------------------------------------------------------------------------
    -- { key = 'w',    mods = HYPER,           action = actions.meta.close_tab },
    -- { key = 'w',    mods = LEADER,          action = actions.meta.close_tab },
    { key = 'r',    mods = HYPER,           action = actions.meta.reload_config },
    { key = 'f',    mods = 'SUPER',         action = actions.meta.toggle_fullscreen },

    ---------------------------------------------------------------------------
    -- basic usage
    ---------------------------------------------------------------------------
    { key = 'q',    mods = 'SUPER',         action = wezterm.action.QuitApplication },
    { key = 'n',    mods = 'SUPER',         action = wezterm.action.SpawnWindow },
    { key = 't',    mods = 'SUPER',         action = wezterm.action.SpawnTab 'CurrentPaneDomain' },

    -- BUG: no matter what key(s)/mod(s) I use, I just can't get this to work...
    { key = 'c',    mods = 'SUPER',    action = wezterm.action.CopyTo "Clipboard" },
    { key = 'v',    mods = 'SUPER',    action = wezterm.action.PasteFrom "Clipboard" },

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
