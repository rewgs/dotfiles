local wezterm = require('wezterm')
local module = {}


-- local HYPER = 'CTRL|ALT'
-- local SHYPER = 'CTRL|ALT|SHIFT'


local actions = {
    meta = { -- i.e. Wezterm itself
        reload_config = wezterm.action.Multiple {
            wezterm.action.DisableDefaultAssignment,
            wezterm.action.ReloadConfiguration
        },
    },
}


local keys = {
    ---------------------------------------------------------------------------
    -- meta
    ---------------------------------------------------------------------------
    { key = 'r',    mods = 'ALT',           action = actions.meta.reload_config },


    ---------------------------------------------------------------------------
    -- multiplexing
    ---------------------------------------------------------------------------
    -- TODO: Maybe use SplitPane() instead? https://wezfurlong.org/wezterm/config/lua/keyassignment/SplitPane.html
    { key = '|',    mods = 'CTRL|SHIFT',  action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
    { key = '_',    mods = 'CTRL|SHIFT',  action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },

    { key = 'h',    mods = 'CTRL',   action = wezterm.action.ActivatePaneDirection('Left') },
    { key = 'j',    mods = 'CTRL',   action = wezterm.action.ActivatePaneDirection('Down') },
    { key = 'k',    mods = 'CTRL',   action = wezterm.action.ActivatePaneDirection('Up') },
    { key = 'l',    mods = 'CTRL',   action = wezterm.action.ActivatePaneDirection('Right') },

    -- Closes the current pane. 
    -- If that was the last pane in the tab, closes the tab. If that was the last tab, closes that 
    -- window. If that was the last window, wezterm terminates. The act of closing a pane shuts down 
    -- the PTY associated with the pane and then kills the process associated with that pane. When 
    -- confirm is true, an overlay will render over the pane to ask you to confirm whether you want 
    -- to close it. See also skip_close_confirmation_for_processes_named. If confirm is false, then 
    -- this action will immediately close the pane without prompting.
    { key = 'w',    mods = 'CTRL',   action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}


function module.apply_to_config(config)
    config.keys = keys
end
return module
