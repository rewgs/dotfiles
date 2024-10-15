return {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- ensures that this plugin is loaded before any others
    config = function()

        -- As of now, this is simply the default configuration.
        require("onedarkpro").setup({
          colors = {}, -- Override default colors or create your own
          highlights = {}, -- Override default highlight groups or create your own
          styles = { -- For example, to apply bold and italic, use "bold,italic"
            types = "bold",
            methods = "NONE",
            numbers = "NONE",
            strings = "NONE",
            comments = "NONE",
            keywords = "NONE",
            constants = "bold",
            functions = "NONE",
            operators = "NONE",
            variables = "NONE",
            parameters = "NONE",
            conditionals = "NONE",
            virtual_text = "NONE",
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
            cursorline = false, -- Use cursorline highlighting
            transparency = false, -- Use a transparent background
            terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
            lualine_transparency = true, -- Center bar transparency
            highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
          }
        })

        vim.cmd("colorscheme onedark")
        -- alts:
        -- vim.cmd("colorscheme onelight")
        -- vim.cmd("colorscheme onedark_vivid")
        -- vim.cmd("colorscheme onedark_dark")
    end
}
