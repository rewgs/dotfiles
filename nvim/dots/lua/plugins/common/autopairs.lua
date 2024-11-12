return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            check_ts = true, -- enable treesitter
            ts_config = {
                lua = { "string" }, -- don't add pairs in lua string treesitter nodes
                javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter node
                java = false, -- don't check treesitter for Java
            },
        })

        local cmp_autopairs = require("nvim-autopairs.completion.cmp") -- imports nvim-autopairs completion functionality
        local cmp = require("cmp") -- imports nvim-cmp plugin for completions

        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
