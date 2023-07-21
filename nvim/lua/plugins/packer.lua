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

    use 'rainbowhxch/accelerated-jk.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'terrortylor/nvim-comment'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use('mg979/vim-visual-multi', { branch = 'master' })
end)
