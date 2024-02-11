require('settings')

---------------------------------------
-- plugins
-- (order is intentional)
---------------------------------------
require('plugins.packer')   -- this must come first

-- themes
require('plugins.config.themes.edge')
-- require('plugins.config.themes.everforest')
-- require('plugins.config.themes.gruvbox-material')
-- require('plugins.config.themes.gruvbox')
require('plugins.config.themes.onedark')
-- require('plugins.config.themes.sonokai')

-- telescope
require('plugins.config.telescope')
-- require('plugins.config.telescope-simulators')

-- all others
require('plugins.config.accelerated-jk')
require('plugins.config.lualine')
require('plugins.config.nvim-treesitter')
require('plugins.config.lsp')
require('plugins.config.nvim-comment')
require('plugins.config.scnvim')
require('plugins.config.luasnip')
require('plugins.config.nvim-cmp')
-- require('plugins.config.nvim-ufo')
require('plugins.config.trouble')
require('plugins.config.todo-comments')

require('color-scheme')
require('keybindings')
