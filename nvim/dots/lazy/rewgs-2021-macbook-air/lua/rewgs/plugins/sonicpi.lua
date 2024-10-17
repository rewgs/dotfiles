return {
    "magicmonty/sonicpi.nvim",
    event = { "VeryLazy" },
    dependencies = {
        "hrsh7th/nvim-cmp",
        "kyazdani42/nvim-web-devicons"
    },
    config = function()
        require("sonicpi").setup({
            server_dir = "", -- It will try to find the SonicPi server
            lsp_diagnostics = false, -- enable LSP diagnostics
            -- mappings = {
            --     { 'n', '<leader>s', require('sonicpi.remote').stop, default_mapping_opts },
            --     { 'i', '<M-s>', require('sonicpi.remote').stop, default_mapping_opts },
            --     { 'n', '<leader>r', require('sonicpi.remote').run_current_buffer, default_mapping_opts },
            --     { 'i', '<M-r>', require('sonicpi.remote').run_current_buffer, default_mapping_opts },
            -- },
        })
    end,
}
