return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "prettier" },
				html = { "prettier" },
				javascript = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				lua = { "stylua" },
				markdown = { "prettier" },
				php = { "php-cs-fixer" },

				-- python = { "isort", "autopep8" },
				python = { "isort", "black" },
				-- python = { "isort", "ruff" },
				-- python = { "isort", "yapf" },

				svelte = { "prettier" },
				typescript = { "prettier" },
			},
			formatters = {
				["clang-format"] = {
					prepend_args = { "--style=file" }, -- Forces clang-format to hunt for the .clang-format file
				},
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
