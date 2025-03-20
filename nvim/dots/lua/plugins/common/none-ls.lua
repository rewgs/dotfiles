return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
        "jay-babu/mason-null-ls.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local mason_null_ls = require("mason-null-ls")
        mason_null_ls.setup({
            ensure_installed = {
                -- "djlint",
                "prettier",
                "prettierd",
                -- "ruff",
                "shfmt",
            },
            automatic_installation = true,
        })

        local null_ls = require("null-ls")
        local sources = {
            require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
            require("none-ls.formatting.ruff_format"),
            -- null_ls.builtins.formatting.prettier.with({
            -- 	filetypes = { "html", "javascript", "json", "yaml", "markdown" },
            -- }),
            null_ls.builtins.formatting.shfmt.with({ args = { "-i", "4" } }),
        }

        -- defers non-ruff LSPs hover
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end
                if client.name == "ruff" then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            end,
            desc = "LSP: Disable hover capability from Ruff",
        })

        -- format on save
        local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
            sources = sources,
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = formatting_augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = true })
                        end,
                    })
                end
            end,
        })
    end,
}
