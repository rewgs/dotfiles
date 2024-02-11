require('settings')

---------------------------------------
-- plugins via packer
---------------------------------------
require('packer.packer')   -- this must come first

-- themes
require('packer.config.onedark')
require('onedark').load()

-- telescope
require('packer.config.telescope')

-- all others
require('packer.config.accelerated-jk')
require('packer.config.lualine')
require('packer.config.nvim-treesitter')
require('packer.config.nvim-comment')
require('packer.config.trouble')
require('packer.config.todo-comments')


---------------------------------------
-- else
---------------------------------------
require('keybindings')
