return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" }, -- Instructs Lazy to load this plugin only when these events happen, i.e. whenever a new buffer or file is opened.
    build = ":TSUpdate",
    config = function()
        local treesitter = require("nvim-treesitter.configs")

        treesitter.setup({
            highlight = { 
                enable = true, -- improves syntax highlighting
            },
            indent = {
                enable = true, -- improves indentation behavior
            },
            ensure_installed = {
                "bash",
                "c",
                "c_sharp",
                "cpp",
                "css",
                "dockerfile",
                "gitignore",
                "go",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "ruby",
                "rust",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                -- keymaps = {
                --     init_selection = "<C-Space>",
                --     node_incremental = "C-Space",
                --     scope_incremental = false,
                --     node_decremental = "<BS>",
                -- },
            },
        })
    end
}
