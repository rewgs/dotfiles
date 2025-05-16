return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter", -- Instructs Lazy to only load this plugin once we've entered Insert mode
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip", -- for auto-completion
		"rafamadriz/friendly-snippets", -- code snippets
		"onsails/lspkind.nvim", -- VS Code-like pictograms
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- loads VS Code-style snippets from installed plugins
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			completion = {
				completeopt = "menu, menuone, preview, noselect",
			},

			snippet = { -- configures how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			-- keymaps
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- closes completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),

			-- sources for autocompletion
			sources = cmp.config.sources({
				-- The order here matters! First one will be checked first.
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),

			-- configures lspkind for VS Code-like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
