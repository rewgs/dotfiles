-- Run gofmt + goimports on save
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        -- require('go.format').gofmpt() -- gofmt only
        require('go.format').goimports() -- goimports + gofmt
    end,
    group = format_sync_grp,
})

return {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("go").setup()
    end,
    event = { "VeryLazy" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
