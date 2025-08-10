local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font_size = 13
	config.font = wezterm.font({
		family = "FiraCode NerdFont",
		weight = "Regular",
	})
end

return module
