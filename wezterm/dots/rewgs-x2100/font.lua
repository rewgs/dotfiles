local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font_size = 12
	config.font = wezterm.font({
		family = "FiraCode Nerd Font",
		-- family = 'Berkeley Mono',
		-- family = 'JetBrains Mono',

		weight = "Regular",
	})
end

return module
