local wezterm = require("wezterm")

-- https://wezfurlong.org/wezterm/config/lua/wezterm/config_builder.html
-- @type config builder object
local config = wezterm.config_builder()

-- Requires common config, and machine-specific config (by hostname);
-- applies `config` to both.
require("common.init").apply_to_config(config)
require(wezterm.hostname() .. ".init").apply_to_config(config)

return config
