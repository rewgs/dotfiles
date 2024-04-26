require("telescope").setup {
    defaults = {
        initial_mode = "insert",
        theme = "dropdown",
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.5,
            },
            vertical = {
                width = 0.5
            }
        },
    },
    extensions = {
        file_browser = {
            initial_mode = "normal",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                ['i'] = {
                    -- your custom insert mode mappings
                },
                ['n'] = {
                    -- your custom normal mode mappings
                },
            },
        },
    },
    pickers = {
        buffers = {
        },
    }
}

-- to get telescope-file-browser loaded and working with telescope, you need to
-- call load_extension after the setup function:
require("telescope").load_extension("file_browser")
