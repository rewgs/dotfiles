local module = {}

local appearance = require("appearance")
local font = require("font")

local keys = require("keys.standard")

function module.apply_to_config(config)
	-- The latter vastly helps overall system graphics performance.
	-- Source: https://github.com/wez/wezterm/issues/2669
	config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"

	config.audible_bell = "Disabled"

	appearance.apply_to_config(config)
	font.apply_to_config(config)

	keys.apply_to_config(config)
end

return module
