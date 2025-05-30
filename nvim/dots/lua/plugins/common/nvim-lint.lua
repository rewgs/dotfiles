-- More or less followed this video: https://www.youtube.com/watch?v=ybUE4D80XSk

return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			-- This apparently causes some issues?
			-- javascript = { "eslint_d" },
			-- typescript = { "eslint_d" },
			-- svelte = { "eslint_d" },

			python = { "ruff" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>fl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file." })
	end,
}
