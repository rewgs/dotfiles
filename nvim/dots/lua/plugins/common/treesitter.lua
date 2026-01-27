return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	event = { "BufReadPre", "BufNewFile" }, -- Instructs Lazy to load this plugin only when these events happen, i.e. whenever a new buffer or file is opened.
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			-- A list of parser names, or "all" (the listed parsers MUST always be installed)
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,

			-- List of parsers to ignore installing (or "all")
			ignore_install = {},

			-- improves syntax highlighting
			highlight = {
				enable = true,
			},

			-- improves indentation behavior
			indent = {
				enable = true,
			},
			ensure_installed = {
				"bash",
				"c",
				"c_sharp",
				"cpp",
				"css",
				"dockerfile",
				"gitignore",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"ruby",
				"rust",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					-- TODO: Figure out better key bindings for this.
					-- init_selection = "<C-Space>",
					-- node_incremental = "C-Space",
					-- scope_incremental = false,
					-- node_decremental = "<BS>",
				},
			},
		})
	end,
}
