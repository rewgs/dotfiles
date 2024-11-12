return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local lualine = require("lualine")
        local lazy_status = require("lazy.status") -- for displaying Lazy pending updates

        lualine.setup({
            options = {
                theme = "onedark",
            },
            sections = {
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates, -- only shows if Lazy has pending updates
                        color = { fg = "#abb2bf" }
                    },
                    {
                        "encoding"
                    },
                    {
                        "fileformat"
                    },
                    {
                        "filetype"
                    },
                }
            }
        })
    end
}
