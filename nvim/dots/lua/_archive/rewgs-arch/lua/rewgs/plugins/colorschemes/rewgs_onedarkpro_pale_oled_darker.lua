-- This is the same colors as my wezterm rewgs_onedark_pale_oled scheme
return {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- ensures that this plugin is loaded before any others
    config = function()

        -- As of now, this is simply the default configuration.
        require("onedarkpro").setup({
          colors = {
                onedark = {
                    -- bg = "#000000", -- black for oled
                    bg = "#27282c", -- original "black" for this colorscheme
                    fg = "#abb2bf",
                    red = "#9a555b", -- dark
                    orange = "#a58b59",
                    yellow = "#af9564",
                    green = "#789266",
                    cyan = "#52787d",
                    blue = "#4f7ea4",
                    purple = "#8d5a9c",
                    white = "#abb2bf",
                    black = "#000000", -- black for oled
                    -- black = "#27282c", -- original "black" for this colorscheme
                    gray = "#89909d",
                    highlight = "#e2be7d", -- unchanged, not sure what this is
                    comment = "#8b80ba",
                },
            }, -- Override default colors or create your own
          highlights = {}, -- Override default highlight groups or create your own
          styles = { -- For example, to apply bold and italic, use "bold,italic"
            types = "NONE", -- Style that is applied to types
            methods = "NONE", -- Style that is applied to methods
            numbers = "NONE", -- Style that is applied to numbers
            strings = "NONE", -- Style that is applied to strings
            comments = "NONE", -- Style that is applied to comments
            keywords = "NONE", -- Style that is applied to keywords
            constants = "NONE", -- Style that is applied to constants
            functions = "NONE", -- Style that is applied to functions
            operators = "NONE", -- Style that is applied to operators
            variables = "NONE", -- Style that is applied to variables
            parameters = "NONE", -- Style that is applied to parameters
            conditionals = "NONE", -- Style that is applied to conditionals
            virtual_text = "NONE", -- Style that is applied to virtual text
          },
          filetypes = { -- Override which filetype highlight groups are loaded
            c = true,
            comment = true,
            go = true,
            html = true,
            java = true,
            javascript = true,
            json = true,
            lua = true,
            markdown = true,
            php = true,
            python = true,
            ruby = true,
            rust = true,
            scss = true,
            toml = true,
            typescript = true,
            typescriptreact = true,
            vue = true,
            xml = true,
            yaml = true,
          },
          plugins = { -- Override which plugin highlight groups are loaded
            aerial = true,
            barbar = true,
            copilot = true,
            dashboard = true,
            flash_nvim = true,
            gitsigns = true,
            hop = true,
            indentline = true,
            leap = true,
            lsp_saga = true,
            lsp_semantic_tokens = true,
            marks = true,
            mini_indentscope = true,
            neotest = true,
            neo_tree = true,
            nvim_cmp = true,
            nvim_bqf = true,
            nvim_dap = true,
            nvim_dap_ui = true,
            nvim_hlslens = true,
            nvim_lsp = true,
            nvim_navic = true,
            nvim_notify = true,
            nvim_tree = true,
            nvim_ts_rainbow = true,
            op_nvim = true,
            packer = true,
            polygot = true,
            rainbow_delimiters = true,
            startify = true,
            telescope = true,
            toggleterm = true,
            treesitter = true,
            trouble = true,
            vim_ultest = true,
            which_key = true,
            vim_dadbod_ui = true,
          },
        
          options = {
            cursorline = false, -- Use cursorline highlighting?
            transparency = false, -- Use a transparent background?
            terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
            lualine_transparency = false, -- Center bar transparency?
            highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
          }
        })

        -- vim.cmd("colorscheme onedark")
        -- alts:
        -- vim.cmd("colorscheme onelight")
        -- vim.cmd("colorscheme onedark_vivid")
        vim.cmd("colorscheme onedark_dark")
    end
}
