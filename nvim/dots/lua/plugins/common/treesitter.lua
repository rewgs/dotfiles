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

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				local buf = ev.buf
				local ft = vim.bo[buf].filetype
				local lang = vim.treesitter.language.get_lang(ft) or ft
				local ok = pcall(vim.treesitter.start, buf, lang)
				if ok then
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				else
					-- Parser not in our list — try to auto-install it.
					pcall(require("nvim-treesitter.install").install, { lang })
				end
			end,
		})
	end,
}
