return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				-- css = { "prettierd" },
				css = { "prettier" },
				-- html = { "prettierd" },
				html = { "prettier" },
				-- javascript = { "prettierd" },
				javascript = { "prettier" },
				-- json = { "prettierd" },
				json = { "prettier" },
				lua = { "stylua" },
				-- markdown = { "prettierd" },
				markdown = { "prettier" },
				php = { "php-cs-fixer" },
				-- python = { "isort", "autopep8" },
				python = { "isort", "black" },
				-- python = { "isort", "ruff" },
				-- python = { "isort", "yapf" },
				-- svelte = { "prettierd" },
				svelte = { "prettier" },
				-- typescript = { "prettierd" },
				typescript = { "prettier" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},

			vim.keymap.set({ "n", "v" }, "<leader>fm", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end),
		})
	end,
}
