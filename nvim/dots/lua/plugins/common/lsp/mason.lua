-- More or less followed this video: https://www.youtube.com/watch?v=ybUE4D80XSk

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
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

		-- LSPs
		mason_lspconfig.setup({
			ensure_installed = {
				"clangd",
				"gopls",
				"lua_ls",
			},
		})

		-- linters and formatters
		mason_tool_installer.setup({
			ensure_installed = {
				-- linters
				"eslint_d",
				"ruff",

				-- formatters
				"isort",
				"black",
				"prettier",
				"prettierd",
				"stylua",
			},
		})
	end,
}
