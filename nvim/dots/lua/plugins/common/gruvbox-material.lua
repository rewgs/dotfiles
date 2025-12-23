return {
	"f4z3r/gruvbox-material.nvim",
	name = "gruvbox-material",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		local theme = require("gruvbox-material")
		theme.setup({
			italics = false,
			contrast = "medium",
			background = {
				transparent = true,
			},
		})
	end,
}
