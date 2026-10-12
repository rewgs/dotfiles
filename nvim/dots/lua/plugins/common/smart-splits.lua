return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		local smart_splits = require("smart-splits")
		smart_splits.setup({})

		vim.keymap.set("n", "<leader>H", smart_splits.resize_left)
		vim.keymap.set("n", "<leader>J", smart_splits.resize_down)
		vim.keymap.set("n", "<leader>K", smart_splits.resize_up)
		vim.keymap.set("n", "<leader>L", smart_splits.resize_right)
	end,
}
