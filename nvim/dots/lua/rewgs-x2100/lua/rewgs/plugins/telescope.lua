-- TODO: get fzf to work!

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" }, -- intelligently truncuates file names if very long
                mappings = {
                    i = { -- keymaps for insert mode
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
            extensions = {
                file_browser = {
                    initial_mode = "normal",
                    -- theme = "ivy",
                    hijack_netrw = true,
                    mappings = {
                        ["i"] = {
                        },
                        ["n"] = {
                        }
                    }
                }
            },
            pickers = {
                buffers = {
                },
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")

        vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })
        vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
        vim.keymap.set("n", "<leader> ",  "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" }) -- was previously <leader>fs
        vim.keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor" })
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
        vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Search through help" })
        vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<CR>", { desc = "Open file browser" })

        -- todo-comments keymaps/integration
        vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todo comments" })
    end,
}