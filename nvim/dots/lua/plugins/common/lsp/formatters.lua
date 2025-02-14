return {
	-- This is the primary plugin for formatting. Sort of like Mason for LSPs.
	-- https://github.com/stevearc/conform.nvim
	"stevearc/conform.nvim",

	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettierd", "prettier", stop_after_first = true }, -- `stop_after_first`: Only run the first available formatter in the list. Defaults to false.
			lua = { "stylua" },
			php = { "php-cs-fixer" },
			-- NOTE: Formatting for Python is being handled via `none-ls.nvim`.
			-- python = { "basedpyright", "pyright", "ruff-lsp", "black", stop_after_first = true },
			-- python = { "black" },
		},

		formatters = {
			["php-cs-fixer"] = {
				command = "php-cs-fixer",
				args = {
					"fix",
					"--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
					"$FILENAME",
				},
				stdin = false,
			},
		},

		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 1000,
			lsp_format = "fallback",
		},

		notify_on_error = true,

		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
	},
}
