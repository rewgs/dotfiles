local theme = require("common.themes.gruvbox-material")
local bg = theme.configurations.dark.palettes.hard
local fg = theme.configurations.dark.global.foregrounds.material

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
		gaps_out = 7,
		border_size = 2,

		col = {
			active_border = theme.rgb(fg.blue),
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
			border_active = theme.rgb(fg.blue),
			border_inactive = theme.rgba("#000000", 0),
		},

		groupbar = {
			enabled = true,
			stacked = false,

			indicator_gap = 0,
			indicator_height = 0,

			keep_upper_gap = false,

			font_family = "FiraCode Nerd Font Retina",
			font_size = 13,
			height = 20,

			gradients = true,
			scrolling = false,
			text_offset = 0,

			render_titles = true,

			col = {
				active = theme.rgb(bg.bg3),
				inactive = theme.rgb(bg.bg1),
			},

			font_weight_active = "bold",
			font_weight_inactive = "normal",

			text_color = theme.rgb(fg.fg0),
			text_color_inactive = theme.rgb(fg.fg1),
		},
	},
})

hl.config({
	misc = {
		background_color = theme.rgb(bg.bg0),
		-- background_color = theme.rgb(bg.bg1),

		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})
