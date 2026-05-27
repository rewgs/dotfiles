local langs = {
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
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()

		-- The main branch API dropped ensure_installed/auto_install from setup().
		-- Install any missing parsers from our list on startup.
		require("nvim-treesitter.install").install(langs)
	end,
}
