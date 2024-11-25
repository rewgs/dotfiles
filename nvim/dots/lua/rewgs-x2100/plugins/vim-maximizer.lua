return {
    "szw/vim-maximizer",
    keys = { -- Instructs Lazy to lazy-load this plugin whenever any of the following key bindings are triggered
        { "<leader>m", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    }
}
