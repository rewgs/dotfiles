require('settings')

---------------------------------------
-- plugins
-- (order is intentional)
---------------------------------------

-- package manager -- this must come first

-- packer
require('plugins.packer')

-- lazy
-- local lazypath = vim.fnstdpath("data") .. "/lazy/lazy.nvim" if not vim.loop.fs_stat(lazypath) then
--     vim.fn.system({
--         "git", "clone", "--filter=blob:none",
--         "https://github.com/folke/lazy.nvim.git",
--         "--branch=stable", -- latest stable release
--         lazypath,
--     })
-- end
-- vim.opt.rtp:prepend(lazypath)
-- require("lazy").setup(plugins, opts)

-- themes
require('plugins.config.themes.edge')
require('plugins.config.themes.everforest')
require('plugins.config.themes.gruvbox-material')
require('plugins.config.themes.gruvbox')
require('plugins.config.themes.onedark')
require('plugins.config.themes.sonokai')

-- telescope
require('plugins.config.telescope')
require('plugins.config.telescope-file-browser')
require('plugins.config.telescope-simulators')

-- all others
require('plugins.config.accelerated-jk')
require('plugins.config.lualine')
require('plugins.config.nvim-treesitter')
require('plugins.config.lsp')
require('plugins.config.nvim-comment')
require('plugins.config.scnvim')
require('plugins.config.luasnip')
require('plugins.config.nvim-cmp')
require('plugins.config.nvim-ufo')
require('plugins.config.trouble')
require('plugins.config.todo-comments')

-- color scheme and keybindings rely on plugins, thus must come last
require('color-scheme')
require('keybindings')
