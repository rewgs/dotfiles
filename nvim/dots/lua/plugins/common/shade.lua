return {
	"sunjon/shade.nvim",
	config = function()
		local shade = require("shade")
		shade.setup({
			overlay_opacity = 66,
			opacity_step = 1,
			keys = {
				brightness_up = "<Leader>bu",
				brightness_down = "<Leader>bd",
				toggle = "<Leader>bt",
			},
		})
	end,
}
