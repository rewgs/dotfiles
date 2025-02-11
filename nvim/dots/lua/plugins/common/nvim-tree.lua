return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- disables netrw
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = {
					".DS_Store",
				},
			},
			git = {
				ignore = false,
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "",
							arrow_open = "",
						},
					},
				},
			},
			view = {
				relativenumber = true,
				side = "right",
				width = 35,
			},
		})

		-- TODO: Add file/dir deleting, making, etc.
		vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		vim.keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Opens file explorer with current file selected" }
		)
		vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "" })
		vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "" })
	end,
}
