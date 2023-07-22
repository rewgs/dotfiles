---------------------------------------------------------------------------------------------------
-- basics
---------------------------------------------------------------------------------------------------

-- I'm not totally sure on what the difference is between these, but
-- some remaps require `nmap` and others require `vmap`.
-- Default to the former, and try the latter if it doesn't work ¯\_(ツ)_/¯
local nmap = vim.api.nvim_set_keymap
local vmap = vim.keymap.set


-- remap leader from `\` to spacebar
vim.g.mapleader = ' '

-- Invoke commands with spacebar or semi-colon
-- nmap('n', '<Space>', ':', { noremap = true })

-- goes down a line, then opens a new line above (which will usually automatically add a tab)
-- stealing alt+j from above, as I'm getting more and more used to the default C-d and C-u
nmap('n', '<A-j>', 'i<CR><Esc>O', { noremap = false })
nmap('i', '<A-j>', '<CR><Esc>O', { noremap = false })

-- Makes it so that up and down movement works more intuitively when navigating wrapped lines
nmap('n', 'j', 'gj', { noremap = true })
nmap('n', 'k', 'gk', { noremap = true })

-- Remaps numeric increment (`C-a`) and decrement (`C-x`) to `=` and `-`, respectively.
-- NOTE: mapping something to C-i (as I originally intended) is impossible, as C-i = Tab in command-line speak.
nmap('n', '=', '<C-a>', { noremap = true })
nmap('n', '-', '<C-x>', { noremap = true })
nmap('v', '=', '<C-a>', { noremap = true })
nmap('v', '-', '<C-x>', { noremap = true })


-- Accelerated jk
nmap('n', 'j', '<Plug>(accelerated_jk_j)', { noremap = true })
nmap('n', 'k', '<Plug>(accelerated_jk_k)', { noremap = true })
nmap('n', 'j', '<Plug>(accelerated_jk_gj)', { noremap = true })
nmap('n', 'k', '<Plug>(accelerated_jk_gk)', { noremap = true })


-- H/L enters Visual Mode
nmap('n', 'H', 'vh', { noremap = true })
nmap('n', 'L', 'vl', { noremap = true })
nmap('v', 'H', 'h', { noremap = true })
nmap('v', 'L', 'l', { noremap = true })


-- J/K enters Visual Block Mode
nmap('n', 'J', '<C-v>j', { noremap = true })
nmap('n', 'K', '<C-v>k', { noremap = true })
nmap('v', 'J', 'j', { noremap = true })
nmap('v', 'K', 'k', { noremap = true })


-- placing the cursor in-between quotes, brackets, etc
nmap('i', "''", "''<Esc>i", { silent = true })
nmap('i', '""', '""<Esc>i', { silent = true })
nmap('i', '[[', '[]<Esc>i', { silent = true })
nmap('i', '[]', '[]<Esc>i', { silent = true })
nmap('i', '{{', '{}<Esc>i', { silent = true })
nmap('i', '{}', '{}<Esc>i', { silent = true })
nmap('i', '((', '()<Esc>i', { silent = true })
nmap('i', '()', '()<Esc>i', { silent = true })


-- remap Escape to clear search results
nmap('n', '<Esc>', '<C-l>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<Esc>', '<C-l>', { silent = true })

-- new buffer -- horizontal split (space -)
nmap('n', '<leader>_', ':split<CR>', { silent = true })
nmap('n', '<leader>_', ':split<CR>', { silent = true })


-- new buffer -- vertical split (space \)
nmap('n', '<leader>|', ':vsplit<CR>', { silent = true })
nmap('n', '<leader>|', ':vsplit<CR>', { silent = true })


-- TODO: continue re-organizing from here on...

-- navigation
nmap('n', '<leader>h', '<C-w>h', { silent = true })
nmap('n', '<leader>j', '<C-w>j', { silent = true })
nmap('n', '<leader>k', '<C-w>k', { silent = true })
nmap('n', '<leader>l', '<C-w>l', { silent = true })

-- move windows
nmap('n', '<leader>H', '<C-w>H', { silent = true })
nmap('n', '<leader>J', '<C-w>J', { silent = true })
nmap('n', '<leader>K', '<C-w>K', { silent = true })
nmap('n', '<leader>L', '<C-w>L', { silent = true })

-- next window
nmap('n', '<leader>`', '<C-w>w', { silent = true })

-- close buffer
nmap('n', '<leader>w', '<C-w>q', { silent = true })
nmap('n', '<leader>h', '<C-w>h', { silent = true })
nmap('n', '<leader>j', '<C-w>j', { silent = true })
nmap('n', '<leader>k', '<C-w>k', { silent = true })
nmap('n', '<leader>l', '<C-w>l', { silent = true })

-- move windows
nmap('n', '<leader>H', '<C-w>H', { silent = true })
nmap('n', '<leader>J', '<C-w>J', { silent = true })
nmap('n', '<leader>K', '<C-w>K', { silent = true })
nmap('n', '<leader>L', '<C-w>L', { silent = true })

-- next window
nmap('n', '<leader>`', '<C-w>w', { silent = true })

-- close buffer
nmap('n', '<leader>w', '<C-w>q', { silent = true })

-- Alias W to w
-- TODO: get this to work!
-- nmap('n', '<s-w>', 'w', {noremap = true})


---------------------------------------------------------------------------------------------------
-- plugins
---------------------------------------------------------------------------------------------------

-- nvim-comment
-- apparently control+/ is C-_
vmap('n', '<C-_>', ':CommentToggle<CR>', { silent = true })
vmap('v', '<C-_>', ':CommentToggle<CR>', { silent = true })

-- telescope
local t = require('telescope.builtin')
-- nmap('n', '<leader>fb', ':Telescope file_browser', { noremap = true }) -- not working
vmap('n', '<leader>fF', t.find_files, {})
vmap('n', '<leader>ff', t.git_files, {}) -- only searches for files being tracked by current git repo
vmap('n', '<leader> ', t.live_grep, {})
vmap('n', '<leader>b', t.buffers, {})
vmap('n', '<leader>fh', t.help_tags, {})

-- nvim.ufo (folding)
nmap('n', '<leader>fo', ':foldopen<CR>', { silent = true })
nmap('n', '<leader>fc', ':foldclose<CR>', { silent = true })

-- telescope-simulators.nvim
nmap('n', '<leader>sim', ':Telescope simulators run<CR>', { silent = true })

-- lsp-zero
-- keybindings list here: https://github.com/VonHeikemen/lsp-zero.nvim/tree/v2.x#keybindings
local lsp = vim.lsp.buf
local diagnostic = vim.diagnostic
vmap('n', '<leader>zh', lsp.hover, {})
vmap('n', '<leader>df', lsp.definition, {})
vmap('n', '<leader>rf', lsp.references, {})
vmap('n', '<leader>rn', lsp.rename, {})
vmap('n', '<leader>fm', lsp.format, {})
vmap('n', '<leader>dg', diagnostic.open_float, {})
vmap('n', '<leader>dn', diagnostic.goto_next, {})
vmap('n', '<leader>dp', diagnostic.goto_prev, {})
