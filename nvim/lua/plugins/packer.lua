-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'

    -- themes
    use 'ellisonleao/gruvbox.nvim'
    use 'navarasu/onedark.nvim'
    use 'sainnhe/edge'
    use 'sainnhe/everforest'
    use 'sainnhe/gruvbox-material'
    use 'sainnhe/sonokai'

    -- lsp-zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- lsp support
            { 'neovim/nvim-lspconfig' }, -- required
            {                            -- optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- optional

            -- autocompletion
            { 'hrsh7th/nvim-cmp' },     -- required
            { 'hrsh7th/cmp-nvim-lsp' }, -- required
            { 'L3MON4D3/LuaSnip' },     -- required
        }
    }

    -- telescope and telescope plugins
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { { 'nvim-lua/plenary.nvim' } } }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use "dimaportenko/telescope-simulators.nvim"

    -- all others
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
    use 'rainbowhxch/accelerated-jk.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'terrortylor/nvim-comment'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use('mg979/vim-visual-multi', { branch = 'master' })
    use { "ibhagwan/fzf-lua",
        -- optional for icon support
        requires = { "nvim-tree/nvim-web-devicons" }
    }
    use { 'davidgranstrom/scnvim' }
    -- use { 'madskjeldgaard/reaper-nvim' }
    -- use { 'davidgranstrom/osc.nvim' }
    use { "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        -- opts = {
        -- -- your configuration comes here
        -- -- or leave it empty to use the default settings
        -- -- refer to the configuration section below
        -- }
    }
end)
