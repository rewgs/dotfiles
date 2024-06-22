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
    tab = {
        rename = wezterm.action.PromptInputLine {
            description = "Rename current tab",

            -- NOTE: Even though the `pane` arg doesn't appear to be used anywhere in this 
            -- function, removing it breaks the function. No idea why. Don't really care.
            -- Just don't get rid of it.
            action = wezterm.action_callback(function(window, pane, line)
                -- `line` will be `nil` if user only hits Escape without entering a value,
                -- an empty string if user only hits Enter, 
                -- or the actual line of text they wrote.
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },
    workspace = {
        launcher = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },

        -- FIXME:
        rename = wezterm.action.PromptInputLine {
            description = "Rename current workspace",
            action = wezterm.action_callback(function(window, line)
                -- `line` will be `nil` if user only hits Escape without entering a value,
                -- an empty string if user only hits Enter, 
                -- or the actual line of text they wrote.
                if line then
                    -- Neither of these approaches work. Not sure what I'm missing here.
                    -- window:active_workspace():set_title(line)
                    -- wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
                end
            end)
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
    { key = 'm',    mods = 'SUPER',         action = wezterm.action.Hide },

    -- copy/paste
    { key = 'c',    mods = 'SUPER',    action = wezterm.action.CopyTo "Clipboard" },
    { key = 'v',    mods = 'SUPER',    action = wezterm.action.PasteFrom "Clipboard" },

    -- tabs
    { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
    { key = '1', mods = 'SUPER', action = wezterm.action.ActivateTab(0) },
    { key = '2', mods = 'SUPER', action = wezterm.action.ActivateTab(1) },
    { key = '3', mods = 'SUPER', action = wezterm.action.ActivateTab(2) },
    { key = '4', mods = 'SUPER', action = wezterm.action.ActivateTab(3) },
    { key = '5', mods = 'SUPER', action = wezterm.action.ActivateTab(4) },
    { key = '6', mods = 'SUPER', action = wezterm.action.ActivateTab(5) },
    { key = '7', mods = 'SUPER', action = wezterm.action.ActivateTab(6) },
    { key = '8', mods = 'SUPER', action = wezterm.action.ActivateTab(7) },
    { key = '9', mods = 'SUPER', action = wezterm.action.ActivateTab(8) },
    { key = '0', mods = 'SUPER', action = wezterm.action.ActivateTab(9) },

    ---------------------------------------------------------------------------
    -- multiplexing
    ---------------------------------------------------------------------------
    -- TODO: Maybe use SplitPane() instead? https://wezfurlong.org/wezterm/config/lua/keyassignment/SplitPane.html
    { key = '|',    mods = 'SUPER|SHIFT',   action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = '-',    mods = 'SUPER|SHIFT',   action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

    -- activate pane
    { key = 'h',    mods = 'SUPER',         action = wezterm.action.ActivatePaneDirection 'Left', },
    { key = 'j',    mods = 'SUPER',         action = wezterm.action.ActivatePaneDirection 'Down', },
    { key = 'k',    mods = 'SUPER',         action = wezterm.action.ActivatePaneDirection 'Up', },
    { key = 'l',    mods = 'SUPER',         action = wezterm.action.ActivatePaneDirection 'Right', },

    -- adjust pane size (coarse)
    { key = 'h',    mods = 'SUPER|SHIFT',   action = wezterm.action.AdjustPaneSize { 'Left', 10} },
    { key = 'j',    mods = 'SUPER|SHIFT',   action = wezterm.action.AdjustPaneSize { 'Down', 10} },
    { key = 'k',    mods = 'SUPER|SHIFT',   action = wezterm.action.AdjustPaneSize { 'Up', 10} },
    { key = 'l',    mods = 'SUPER|SHIFT',   action = wezterm.action.AdjustPaneSize { 'Right', 10} },

    { key = 'Space', mods = 'SUPER|SHIFT',  action = wezterm.action.ShowTabNavigator },
    { key = 'r', mods = 'SUPER', action = actions.tab.rename },

    -- { key = 's',    mods = 'SUPER',         action = wezterm.action.QuickSelect },

    -- workspaces
    { key = 'o', mods = 'SUPER', action = actions.workspace.launcher },

    -- NOTE: actions.workspace.rename not working
    -- { key = 'r', mods = 'SUPER|SHIFT', action = actions.workspace.rename },

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
