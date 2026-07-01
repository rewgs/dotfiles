local theme = require("common.themes.atom-one")
local p = theme.override(theme.configurations.dark.palettes.default, {
	groupbar_active_bg = "#404452",
	groupbar_active_text = "#b2b7c1",
})

hl.config({
	ecosystem = {
		no_update_news = true,
	},
})

hl.config({
	general = {
		-- gaps_in = 5,
		-- gaps_out = 10,
		-- border_size = 3,

		gaps_in = 4,
		gaps_out = 8,
		border_size = 2,

		col = {
			active_border = theme.rgb(p.blue),
			inactive_border = theme.rgba("#000000", 0),
		},

		layout = "dwindle",
		-- layout = "master",
	},
})

hl.config({
	group = {
		auto_group = false,
		insert_after_current = true,
		focus_removed_window = true,

		col = {
			border_active = theme.rgb(p.blue),
			border_inactive = theme.rgba("#000000", 0),
		},

		groupbar = {
			enabled = true,
			stacked = false,

			indicator_gap = 0,
			indicator_height = 0,

			keep_upper_gap = false,

			font_family = "FiraCode Nerd Font Retina",
			font_size = 12,
			-- height = 20,
			height = 16,

			gradients = true,
			scrolling = false,
			text_offset = 0,

			render_titles = true,

			col = {
				active = theme.rgb(p.groupbar_active_bg),
				inactive = theme.rgb(p.bg_d),
			},

			font_weight_active = "bold",
			font_weight_inactive = "normal",

			text_color = theme.rgb(p.groupbar_active_text),
			text_color_inactive = theme.rgb(p.fg),
		},
	},
})

hl.config({
	misc = {
		-- background_color = theme.rgb(p.bg0),
		-- background_color = theme.rgb(p.bg_d),

		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})
