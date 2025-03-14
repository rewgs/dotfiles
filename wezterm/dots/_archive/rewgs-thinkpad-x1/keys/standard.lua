local wezterm = require('wezterm')
local module = {}

local HYPER = 'CTRL|ALT'
local SHYPER = 'CTRL|ALT|SHIFT'


local actions = {
    meta = { -- i.e. Wezterm itself
        reload_config = wezterm.action.Multiple {
            wezterm.action.DisableDefaultAssignment,
            wezterm.action.ReloadConfiguration
        },
    },
    tab = {
        rename = wezterm.action.PromptInputLine {
            description = "Rename current tab",
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
}


local keys = {
    ---------------------------------------------------------------------------
    -- wezterm
    ---------------------------------------------------------------------------
    { key = 'r',    mods = SHYPER,    action = actions.meta.reload_config },
    { key = 't',    mods = HYPER,         action = wezterm.action.SpawnTab 'CurrentPaneDomain' },

    ---------------------------------------------------------------------------
    -- clipboard
    ---------------------------------------------------------------------------
    { key = 'c',    mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo "ClipboardAndPrimarySelection" },
    { key = 'v',    mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom "Clipboard" },
    { key = 'v',    mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom "PrimarySelection" },

    ---------------------------------------------------------------------------
    -- multiplexing
    ---------------------------------------------------------------------------
    -- TODO: Maybe use SplitPane() instead? https://wezfurlong.org/wezterm/config/lua/keyassignment/SplitPane.html
    { key = '|',    mods = SHYPER,        action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
    { key = '_',    mods = SHYPER,        action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },

    -- panes
    { key = 'h',    mods = HYPER,              action = wezterm.action.ActivatePaneDirection('Left') },
    { key = 'j',    mods = HYPER,              action = wezterm.action.ActivatePaneDirection('Down') },
    { key = 'k',    mods = HYPER,              action = wezterm.action.ActivatePaneDirection('Up') },
    { key = 'l',    mods = HYPER,              action = wezterm.action.ActivatePaneDirection('Right') },

    -- resize panes
    { key = 'h',    mods = SHYPER,   action = wezterm.action.AdjustPaneSize { 'Left', 10} },
    { key = 'j',    mods = SHYPER,   action = wezterm.action.AdjustPaneSize { 'Down', 10} },
    { key = 'k',    mods = SHYPER,   action = wezterm.action.AdjustPaneSize { 'Up', 10} },
    { key = 'l',    mods = SHYPER,   action = wezterm.action.AdjustPaneSize { 'Right', 10} },

    -- tabs
    { key = 'Tab', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },
    { key = '1', mods = HYPER, action = wezterm.action.ActivateTab(0) },
    { key = '2', mods = HYPER, action = wezterm.action.ActivateTab(1) },
    { key = '3', mods = HYPER, action = wezterm.action.ActivateTab(2) },
    { key = '4', mods = HYPER, action = wezterm.action.ActivateTab(3) },
    { key = '5', mods = HYPER, action = wezterm.action.ActivateTab(4) },
    { key = '6', mods = HYPER, action = wezterm.action.ActivateTab(5) },
    { key = '7', mods = HYPER, action = wezterm.action.ActivateTab(6) },
    { key = '8', mods = HYPER, action = wezterm.action.ActivateTab(7) },
    { key = '9', mods = HYPER, action = wezterm.action.ActivateTab(8) },
    { key = '0', mods = HYPER, action = wezterm.action.ActivateTab(9) },

    -- Closes the current pane. 
    -- If that was the last pane in the tab, closes the tab. If that was the last tab, closes that 
    -- window. If that was the last window, wezterm terminates. The act of closing a pane shuts down 
    -- the PTY associated with the pane and then kills the process associated with that pane. When 
    -- confirm is true, an overlay will render over the pane to ask you to confirm whether you want 
    -- to close it. See also skip_close_confirmation_for_processes_named. If confirm is false, then 
    -- this action will immediately close the pane without prompting.
    { key = 'w',    mods = HYPER,              action = wezterm.action.CloseCurrentPane({ confirm = true }) },
}


function module.apply_to_config(config)
    config.keys = keys
end
return module
