require('autocommands')
require('settings')

---------------------------------------
-- plugins
-- (order is intentional)
---------------------------------------
require('plugins.packer')   -- this must come first

-- themes
require('plugins.config.themes.gruvbox')
require('plugins.config.themes.onedark')
require('plugins.config.accelerated-jk')

-- lsp
require('plugins.config.mason')
require('plugins.config.mason-lspconfig')
require('plugins.config.lspconfig')

-- telescope
require('plugins.config.telescope')
require('plugins.config.telescope-file-browser')
require('plugins.config.telescope-simulators')

-- all others
require('plugins.config.lualine')
require('plugins.config.nvim-comment')
require('plugins.config.nvim-treesitter')
require('plugins.config.nvim-ufo')
require('plugins.config.undotree')


require('color-scheme')
require('keybindings')
require('lsp')
