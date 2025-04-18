return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				css = { "prettierd" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				json = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				php = { "php-cs-fixer" },
				python = { "isort", "ruff" },
				svelte = { "prettierd" },
				typescript = { "prettierd" },
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

	-- opts = {
	-- 	formatters_by_ft = {
	-- 		-- `stop_after_first`: Only run the first available formatter in the list. Defaults to false.
	-- 		html = { "prettierd", "prettier", stop_after_first = true },
	-- 		javascript = { "prettierd", "prettier", stop_after_first = true },
	-- 		lua = { "stylua" },
	-- 		php = { "php-cs-fixer" },
	-- 		-- python = { "basedpyright", "pyright", "ruff-lsp", "black", stop_after_first = true },
	-- 		-- python = { "black" },
	-- 	},
	--
	-- 	formatters = {
	-- 		["php-cs-fixer"] = {
	-- 			command = "php-cs-fixer",
	-- 			args = {
	-- 				"fix",
	-- 				"--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
	-- 				"$FILENAME",
	-- 			},
	-- 			stdin = false,
	-- 		},
	-- 		-- ["prettier"] = {
	-- 		-- 	-- Use a specific prettier parser for a filetype
	-- 		-- 	-- Otherwise, prettier will try to infer the parser from the file name
	-- 		-- 	ft_parsers = {
	-- 		-- 		    javascript = "babel",
	-- 		-- 		    javascriptreact = "babel",
	-- 		-- 		    typescript = "typescript",
	-- 		-- 		    typescriptreact = "typescript",
	-- 		-- 		    vue = "vue",
	-- 		-- 		    css = "css",
	-- 		-- 		    scss = "scss",
	-- 		-- 		    less = "less",
	-- 		-- 		    html = "html",
	-- 		-- 		    json = "json",
	-- 		-- 		    jsonc = "json",
	-- 		-- 		    yaml = "yaml",
	-- 		-- 		    markdown = "markdown",
	-- 		-- 		    ["markdown.mdx"] = "mdx",
	-- 		-- 		    graphql = "graphql",
	-- 		-- 		    handlebars = "glimmer",
	-- 		-- 	},
	-- 		-- 	-- Use a specific prettier parser for a file extension
	-- 		-- 	ext_parsers = {
	-- 		-- 		qmd = "markdown",
	-- 		-- 	},
	-- 		-- },
	-- 	},
	--
	-- 	format_on_save = {
	-- 		-- These options will be passed to conform.format()
	-- 		timeout_ms = 1000,
	-- 		lsp_format = "fallback",
	-- 	},
	--
	-- 	notify_on_error = true,
	--
	-- 	keys = {
	-- 		{
	-- 			"<leader>fm",
	-- 			function()
	-- 				require("conform").format({ async = false })
	-- 			end,
	-- 			mode = "",
	-- 			desc = "Format buffer",
	-- 		},
	-- 	},
	-- },
}
