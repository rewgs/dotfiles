-- See https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
	ecosystem = {
		no_update_news = true,
	},
})

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 3,

		col = {
			-- active_border = "rgb(61afef)",
			-- inactive_border = "rgba(00000000)",
			active_border = "rgb(7daea3)",
			inactive_border = "rgba(00000000)",
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
			border_active = "rgb(7daea3)",
			border_inactive = "rgba(00000000)",
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
				active = "rgb(3c3836)",
				inactive = "rgb(282828)",
			},

			font_weight_active = "bold",
			font_weight_inactive = "normal",

			text_color = "rgb(d4be98)",
			text_color_inactive = "rgb(ddc7a1)",
		},
	},
})

hl.config({
	misc = {
		background_color = "rgb(1d2021)",
		-- background_color = "rgb(282828)",

		disable_hyprland_logo = true,
		disable_splash_rendering = true,
	},
})
