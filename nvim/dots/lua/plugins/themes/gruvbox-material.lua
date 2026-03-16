return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000, -- ensures that this plugin is loaded before any others
	config = function()
		vim.g.gruvbox_material_enable_italic = false
		vim.g.gruvbox_material_transparent_background = 2
		vim.g.gruvbox_material_dim_inactive_windows = 1
		vim.g.gruvbox_material_ui_contrast = "high"

		vim.cmd.colorscheme("gruvbox-material")
	end,
}
