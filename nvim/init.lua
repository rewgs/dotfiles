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

-- telescope
require('plugins.config.telescope')
require('plugins.config.telescope-file-browser')
require('plugins.config.telescope-simulators')

-- all others
require('plugins.config.lualine')
require('plugins.config.nvim-treesitter')
require('plugins.config.lsp')
require('plugins.config.nvim-comment')
require('color-scheme')
require('keybindings')
