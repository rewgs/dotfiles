require('settings')

---------------------------------------
-- plugins
-- (order is intentional)
---------------------------------------
require('plugins.packer')   -- this must come first

-- themes
require('plugins.config.themes.onedark')

-- telescope
require('plugins.config.telescope')

-- all others
require('plugins.config.accelerated-jk')
require('plugins.config.lualine')
require('plugins.config.nvim-treesitter')
require('plugins.config.nvim-comment')
require('plugins.config.trouble')
require('plugins.config.todo-comments')

require('color-scheme')
require('keybindings')
