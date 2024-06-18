local wezterm = require('wezterm')

-- https://wezfurlong.org/wezterm/config/lua/wezterm/config_builder.html
-- @type config builder object
local config = wezterm.config_builder()

local common_config = require('common.init')
common_config.apply_to_config(config)

-- TODO: move to common/helpers.lua
local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

-- TODO: move to common/helpers.lua
local is_macOS = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

-- TODO: move to common/helpers.lua
-- local is_windows = function()
--     return wezterm.target_triple:find("windows") ~= nil
-- end


if is_linux() then
    local linux_config = require('linux.init')
    linux_config.apply_to_config(config)
end


if is_macOS() then
    local macOS_config = require('macOS.init')
    macOS_config.apply_to_config(config)
end


return config
