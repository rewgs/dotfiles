local wezterm = require('wezterm')

-- https://wezfurlong.org/wezterm/config/lua/wezterm/config_builder.html
-- @type config builder object
local config = wezterm.config_builder()

local _ = require('common.helpers') -- requires only the helper functions; this is placed in common for cleanliness
local common_config = require('common.init') -- requires all other common files
local linux_config = require('linux.init')
local macOS_config = require('macOS.init')


-- common configs
common_config.apply_to_config(config)

-- os-specific configs
if _.is_linux() then linux_config.apply_to_config(config)
elseif _.is_macOS() then macOS_config.apply_to_config(config)
-- TODO:
-- elseif _.is_windows() then
else
-- TODO: panic/throw error that OS isn't (yet) supported
end


return config
