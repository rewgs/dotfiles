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

    -- telescope and telescope plugins
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = {{ 'nvim-lua/plenary.nvim' }}}
    use 'nvim-telescope/telescope-file-browser.nvim'
    use "dimaportenko/telescope-simulators.nvim"

    -- lsp and snippets
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use {'neoclide/coc.nvim', branch = 'release'}
    -- (the following is what was recommended in this video:
    -- https://www.youtube.com/watch?v=h4g0m0Iwmys&list=WL&index=125)
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'          -- need to configure
    use 'L3MON4D3/LuaSnip'              -- need to configure
    use 'saadparwaiz1/cmp_luasnip'      -- need to configure
    use 'rafamadriz/friendly-snippets'  -- need to configure

    use 'rainbowhxch/accelerated-jk.nvim'
    use 'ThePrimeagen/harpoon'
    use 'nvim-lualine/lualine.nvim'
    use 'terrortylor/nvim-comment'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
    use 'mbbill/undotree'
    use('mg979/vim-visual-multi', { branch = 'master' })
end)
