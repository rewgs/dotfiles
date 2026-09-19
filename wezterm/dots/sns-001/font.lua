local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font_size = 14
	config.font = wezterm.font_with_fallback({
		{ family = "FiraCode Nerd Font", weight = "Regular" },
		{ family = "JetBrains Mono", weight = "Regular" },
	})
end

return module
