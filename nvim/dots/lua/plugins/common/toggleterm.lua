return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			shade_terminals = true,
		})

		vim.keymap.set("n", "<C-`>", "<Cmd>ToggleTerm<CR>", { desc = "" })

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<C-`>", "<Cmd>ToggleTerm<CR>", { desc = "" })
			-- vim.keymap.set("t", "<M-h>", "<C-w>h<CR>", opts)
			-- vim.keymap.set("t", "<M-j>", "<C-w>j<CR>", opts)
			-- vim.keymap.set("t", "<M-k>", "<C-w>k<CR>", opts)
			-- vim.keymap.set("t", "<M-l>", "<C-w>l<CR>", opts)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
	end,
}
