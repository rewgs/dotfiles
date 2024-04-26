-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'navarasu/onedark.nvim'

    -- telescope and telescope plugins
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {
            { 'nvim-lua/plenary.nvim' }
        }
    }
    use "nvim-telescope/telescope-file-browser.nvim"

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'rainbowhxch/accelerated-jk.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'terrortylor/nvim-comment'
    use('mg979/vim-visual-multi', { branch = 'master' })
    use { "ibhagwan/fzf-lua",
        -- optional for icon support
        requires = { "nvim-tree/nvim-web-devicons" }
    }
    use { 'davidgranstrom/scnvim' }
    use { "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        -- opts = {
        -- -- your configuration comes here
        -- -- or leave it empty to use the default settings
        -- -- refer to the configuration section below
        -- }
    }
    use { "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    }
end)
