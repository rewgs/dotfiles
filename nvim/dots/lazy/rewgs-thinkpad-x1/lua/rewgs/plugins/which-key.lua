return {
    "folke/which-key.nvim",
    event = "VeryLazy", -- loads as lazily as possible
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500 -- amount of time to wait after pressing leader key for which-key GUI to open
    end,
    opts = {
        -- Left empty on purpose so that it uses the default settings
    }
}
