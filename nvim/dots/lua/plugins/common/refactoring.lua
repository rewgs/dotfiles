return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require('refactoring').setup({
            prompt_func_return_type = {
                go = false,
                java = false,

                cpp = false,
                c = false,
                h = false,
                hpp = false,
                cxx = false,
            },
            prompt_func_param_type = {
                go = false,
                java = false,

                cpp = false,
                c = false,
                h = false,
                hpp = false,
                cxx = false,
            },
            printf_statements = {},
            print_var_statements = {},
            show_success_message = false, -- shows a message with information about the refactor on success

            -- Prompt for a refactor to apply when the remap is triggered
            -- Note that not all refactor support both normal and visual mode
            -- -- i.e. [Refactor] Inlined 3 variable occurrences
            -- vim.keymap.set(
            --     {"n", "x"},
            --     "<leader>rr",
            --     function()
            --         require('refactoring').select_refactor() 
            --     end
            -- )

            -- Load refactoring Telescope extension
            -- require("telescope").load_extension("refactoring")
            -- vim.keymap.set(
            -- 	{"n", "x"},
            -- 	"<leader>rr",
            -- 	function() require('telescope').extensions.refactoring.refactors() end
            -- )

        })
    end
}
