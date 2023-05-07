-------------------------------------------------------------------------------
-- map()
-- Enables cleaner key binding remapping

local M = {}

function M.map(mode, custom_key, stock_key, opts)
    local options = { noremap = true }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.api.nvim_set_keymap(mode, custom_key, stock_key, options)
end

return M
-------------------------------------------------------------------------------
-- highlight_on_yank()
-- to do