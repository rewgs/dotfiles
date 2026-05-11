-- Dynamically switches the active keys config.
-- If in a tmux session, uses keys.tmux.
-- Otherwise, uses keys.standard.

local wezterm = require('wezterm')

local function inTmux() --> bool
    local tmux = os.getenv("TMUX")
    if tmux ~= nil then
        return true
    else
        return false
    end
end

-- io.write(tostring(inTmux()))
wezterm.on('swap-keys', function(window, pane)
    local overrides = window:get_config_overrides() or {}
end)

return {
    keys = {
        {
            key = 's',
            mods = 'CMD|CTRL',
            action = wezterm.action.EmitEvent('swap-keys')
        },
    },
}
