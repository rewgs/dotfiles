-- More or less followed this video: https://www.youtube.com/watch?v=ybUE4D80XSk

return {
	"mason-org/mason.nvim",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- linters and formatters
		mason_tool_installer.setup({
			ensure_installed = {
				-- linters
				-- "eslint_d",
				"eslint-lsp",

				-- formatters
				"isort",
				-- "autopep8",
				"black",
				"prettier",
				-- "prettierd",
				"stylua",
				"typescript-language-server",
				-- "yapf",

				-- both
				-- "ruff",
			},
		})
	end,
}
