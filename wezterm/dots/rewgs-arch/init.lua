local module = {}

local host = "rewgs-x1c11"

local appearance = require(host .. ".appearance")
local font = require(host .. ".font")
local keys = require(host .. ".keys.alt") -- ALT key as main mod

function module.apply_to_config(config)
	config.enable_wayland = true -- NOTE: Apparently this has to be false to work???
	config.window_decorations = "NONE"

	appearance.apply_to_config(config)
	font.apply_to_config(config)
	keys.apply_to_config(config)
end

return module
