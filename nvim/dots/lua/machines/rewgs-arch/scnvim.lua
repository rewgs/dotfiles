return {
	"davidgranstrom/scnvim",
	ft = "supercollider",

	-- NOTE: This fixes an issue with Neovim's built-in .sc filetype detection being content-based.
	-- It reads the first 25 lines looking for SuperCollider patterns (var <, |word|, ^this.*, etc.),
	-- and if none match, it defaults to scala, not supercollider.
	-- So, an empty or new .sc file never triggers `ft = "supercollider`, and this plugin never loads.
	-- The init() function runs before lazy loading (i.e. before the file type is checked),
	-- so this ensures that .sc files are always identified as supercollider (which then triggers the plugin to load).
	-- HOWEVER: This means that Scala files will _not_ be recognized as such.
	-- I don't write any Scala and don't plan to, so this will probably never be a problem, but it's worth flagging just in case.
	init = function()
		vim.filetype.add({ extension = { sc = "supercollider" } })
	end,

	config = function()
		local scnvim = require("scnvim")
		local map = scnvim.map
		local map_expr = scnvim.map_expr
		scnvim.setup({
			keymaps = {
				["<M-e>"] = map("editor.send_line", { "i", "n" }),
				["<C-e>"] = {
					map("editor.send_block", { "i", "n" }),
					map("editor.send_selection", "x"),
				},
				["<CR>"] = map("postwin.toggle"),
				["<M-CR>"] = map("postwin.toggle", "i"),
				["<M-L>"] = map("postwin.clear", { "n", "i" }),
				["<C-k>"] = map("signature.show", { "n", "i" }),
				["<F12>"] = map("sclang.hard_stop", { "n", "x", "i" }),
				["<leader>st"] = map("sclang.start"),
				["<leader>sk"] = map("sclang.recompile"),
				["<F1>"] = map_expr("s.boot"),
				["<F2>"] = map_expr("s.meter"),
			},
			editor = {
				highlight = {
					color = "IncSearch",
				},
			},
			postwin = {
				float = {
					enabled = true,
				},
			},
		})
	end,
}
