local wezterm = require('wezterm')
local module = {}


function module.is_linux()
	return wezterm.target_triple:find("linux") ~= nil
end


function module.is_macOS()
	return wezterm.target_triple:find("darwin") ~= nil
end


function module.is_windows()
    return wezterm.target_triple:find("windows") ~= nil
end


return module
