-- More or less followed this video: https://www.youtube.com/watch?v=ybUE4D80XSk

return {
	"mason-org/mason.nvim",
	-- NOTE: Pinning version until I have time to deal with v2 API changes.
	version = "1.11.0",
	dependencies = {
		-- NOTE: Pinning version until I have time to deal with v2 API changes.
		{ "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
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
				-- "ruff",

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
