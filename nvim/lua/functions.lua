local M = {}

function M.map(mode, new_key, old_key, opts)
  local options = { noremap = true }
  
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  
  vim.api.nvim_set_keymap(mode, new_key, old_key, options)
end

return M
