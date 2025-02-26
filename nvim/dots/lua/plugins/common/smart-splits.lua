return {
    "mrjones2014/smart-splits.nvim",
    config = function()
        require("smart-splits").setup({
            ignored_buftypes = {
                "nofile",
                "quickfix",
                "prompt",
            },
            ignored_filetypes = {
                "NvimTree",
            },
            default_amount = 3,
            at_edge = "wrap",
            float_win_behavior = "previous",
            move_cursor_same_row = false,
            cursor_follows_swapped_bufs = false,

            vim.keymap.set("n", "<leader>H", require("smart-splits").resize_left),
            vim.keymap.set("n", "<leader>J", require("smart-splits").resize_down),
            vim.keymap.set("n", "<leader>K", require("smart-splits").resize_up),
            vim.keymap.set("n", "<leader>L", require("smart-splits").resize_right),
        })
    end,
}
