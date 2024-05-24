vim.g.mapleader = " " -- Maps Leader key to Spacebar.

-- vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- TODO: Figure out why this isn't working
-- remap Escape to clear search results
-- vim.api.nvim_set_keymap('n', '<ESC>', '<C-l>', { noremap = true })
vim.keymap.set('n', '<Esc>', '<C-l>', { desc = "Clear search highlights", noremap = true })

-- increment/decrement numbers
-- increment: `Alt` + `Shift` + `=` (`Shift` + `=` = `+`)
-- decrement: `Alt` +           `-`
vim.keymap.set('n', '<A-+>', "<C-a>", { desc = "Increment number" })
vim.keymap.set('n', '<A-->', "<C-x>", { desc = "Decrement number" })

-- buffers
