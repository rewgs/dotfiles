vim.g.mapleader = " " -- Maps Leader key to Spacebar.

-- vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- remap Escape to clear search results
vim.api.nvim_set_keymap('n', '<Esc>', '<C-l>', { desc = "clear search highlights", silent = true })

-- increment/decrement numbers
-- increment: `Alt` + `Shift` + `=` (`Shift` + `=` = `+`)
-- decrement: `Alt` +           `-`
vim.keymap.set('n', '<A-+>', "<C-a>", { desc = "Increment number" })
vim.keymap.set('n', '<A-->', "<C-x>", { desc = "Decrement number" })

-- buffers
vim.api.nvim_set_keymap('n', '<leader>_', ':split<CR>',     { desc = "horizontal split", silent = true })
vim.api.nvim_set_keymap('n', '<leader>|', ':vsplit<CR>',    { desc = "vertical split",   silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h',         { desc = "navigate left", silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j',         { desc = "navigate down", silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k',         { desc = "navigate up", silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l',         { desc = "navigate right", silent = true })
vim.api.nvim_set_keymap('n', '<leader>rw', ':vertical resize +5<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>rW', ':vertical resize -5<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>rt', ':horizontal resize +5<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>rT', ':horizontal resize -5<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ":tabnew<CR>", { desc = "new tab" })
vim.api.nvim_set_keymap('n', '<leader>w', ":tabclose<CR>", { desc = "close tab" })
vim.api.nvim_set_keymap('n', '<leader><Tab>', ":tabnext<CR>", { desc = "next tab" })
vim.api.nvim_set_keymap('n', '<leader><S-Tab>', ":tabprevious<CR>", { desc = "next tab" })
