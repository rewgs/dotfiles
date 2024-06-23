local wezterm = require('wezterm')
local hostname = wezterm.hostname()

-- https://wezfurlong.org/wezterm/config/lua/wezterm/config_builder.html
-- @type config builder object
local config = wezterm.config_builder()

-- local _ = require('common.helpers') -- requires only the helper functions; this is placed in common for cleanliness

-- common; applies to all machines
local common_config = require('common.init') -- requires all other common files
common_config.apply_to_config(config)

-- machine-specific configs
if hostname == 'rewgs-thinkpad-x1' then
    local machine_config = require('rewgs-thinkpad-x1.init')
    machine_config.apply_to_config(config)
elseif hostname == 'rewgs-2021-macbook-air' then
    local machine_config = require('rewgs-2021-macbook-air.init')
    machine_config.apply_to_config(config)
end


-- common configs

-- if _.is_linux() then linux_config.apply_to_config(config)
-- elseif _.is_macOS() then macOS_config.apply_to_config(config)
-- TODO:
-- elseif _.is_windows() then
-- else
-- TODO: panic/throw error that OS isn't (yet) supported
-- end


return config
