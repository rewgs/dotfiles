---------------------------------------------------------------------------------------------------
-- basics
---------------------------------------------------------------------------------------------------

local keymap = vim.api.nvim_set_keymap

-- TODO: Make Q call q because I always accidentally type Q instead of q


-- remap leader from `\` to `;`
vim.g.mapleader = ';'


-- Invoke commands with spacebar or semi-colon
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'n',    '<Space>',          ':',                        {noremap = true})


-- goes down a line, then opens a new line above (which will usually automatically add a tab)
-- stealing alt+j from above, as I'm getting more and more used to the default C-d and C-u
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'n',    '<A-j>',            'i<CR><Esc>O',              {noremap = false})
keymap( 'i',    '<A-j>',            '<CR><Esc>O',               {noremap = false})


-- Makes it so that up and down movement works more intuitively when navigating wrapped lines
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'n',    'j',                'gj',                       {noremap = true})
keymap( 'n',    'k',                'gk',                       {noremap = true})


-- Remaps numeric increment (`C-a`) and decrement (`C-x`) to `=` and `-`, respectively.
-- NOTE: mapping something to C-i (as I originally intended) is impossible, as C-i = Tab in command-line speak.
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'n',    '=',                '<C-a>', 			        {noremap = true})
keymap( 'n',    '-',                '<C-x>',			        {noremap = true})
keymap( 'v',    '=',                '<C-a>', 			        {noremap = true})
keymap( 'v',    '-',                '<C-x>',			        {noremap = true})


-- Accelerated jk
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'n',    'j',                '<Plug>(accelerated_jk_j)', {noremap = true})
keymap( 'n',    'k',                '<Plug>(accelerated_jk_k)', {noremap = true})
keymap( 'n',    'j',                '<Plug>(accelerated_jk_gj)',{noremap = true})
keymap( 'n',    'k',                '<Plug>(accelerated_jk_gk)',{noremap = true})


-- H/L enters Visual Mode
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'n',    'H',                'vh',                       {noremap = true})
keymap( 'n',    'L',                'vl',                       {noremap = true})
keymap( 'v',    'H',                'h',                        {noremap = true})
keymap( 'v',    'L',                'l',                        {noremap = true})


-- J/K enters Visual Block Mode
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'n',    'J',                '<C-v>j',                   {noremap = true})
keymap( 'n',    'K',                '<C-v>k',                   {noremap = true})
keymap( 'v',    'J',                'j',                        {noremap = true})
keymap( 'v',    'K',                'k',                        {noremap = true})


-- placing the cursor in-between quotes, brackets, etc
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'i',    "''",               "''<Esc>i",                 {silent = true})
keymap( 'i',    '""',               '""<Esc>i',                 {silent = true})
keymap( 'i',    '[[',               '[]<Esc>i',                 {silent = true})
keymap( 'i',    '[]',               '[]<Esc>i',                 {silent = true})
keymap( 'i',    '{{',               '{}<Esc>i',                 {silent = true})
keymap( 'i',    '{}',               '{}<Esc>i',                 {silent = true})
keymap( 'i',    '((',               '()<Esc>i',                 {silent = true})
keymap( 'i',    '()',               '()<Esc>i',                 {silent = true})


-- remap Escape to clear search results 
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'n',    '<Esc>',            '<C-l>',                    {silent = true})


-- new buffer -- horizontal split (space -)
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'n',    '<leader>-',        ':split<CR>',               {silent = true})
keymap( 'n',    '<Leader>-',        ':split<CR>',               {silent = true})


-- new buffer -- vertical split (space \)
--      MODE    KEYS                ACTION(S)                   OPTIONS
keymap( 'n',    '<leader>\\',       ':vsplit<CR>',              {silent = true})
keymap( 'n',    '<Leader>\\',       ':vsplit<CR>',              {silent = true})


-- TODO: continue re-organizing from here on...

-- navigation
keymap('n', '<leader>h', '<C-w>h', {silent = true})
keymap('n', '<leader>j', '<C-w>j', {silent = true})
keymap('n', '<leader>k', '<C-w>k', {silent = true})
keymap('n', '<leader>l', '<C-w>l', {silent = true})

-- move windows
keymap('n', '<leader>H', '<C-w>H', {silent = true})
keymap('n', '<leader>J', '<C-w>J', {silent = true})
keymap('n', '<leader>K', '<C-w>K', {silent = true})
keymap('n', '<leader>L', '<C-w>L', {silent = true})

-- next window
keymap('n', '<leader>`', '<C-w>w', {silent = true})

-- close buffer
keymap('n', '<leader>w', '<C-w>q', {silent = true})
keymap('n', '<Leader>h', '<C-w>h', {silent = true})
keymap('n', '<Leader>j', '<C-w>j', {silent = true})
keymap('n', '<Leader>k', '<C-w>k', {silent = true})
keymap('n', '<Leader>l', '<C-w>l', {silent = true})

-- move windows
keymap('n', '<Leader>H', '<C-w>H', {silent = true})
keymap('n', '<Leader>J', '<C-w>J', {silent = true})
keymap('n', '<Leader>K', '<C-w>K', {silent = true})
keymap('n', '<Leader>L', '<C-w>L', {silent = true})

-- next window
keymap('n', '<Leader>`', '<C-w>w', {silent = true})

-- close buffer
keymap('n', '<Leader>w', '<C-w>q', {silent = true})

-- Alias W to w
-- TODO: get this to work!
-- keymap('n', '<s-w>', 'w', {noremap = true})


---------------------------------------------------------------------------------------------------
-- plugins 
---------------------------------------------------------------------------------------------------

-- harpoon
-- keymap('n', '<leader>ha', require("harpoon.mark").add_file(), {silent = true})

-- nvim-comment
-- apparently control+/ is C-_
keymap('n', '<C-_>', ':CommentToggle<CR>', {silent = true})
keymap('v', '<C-_>', ':CommentToggle<CR>', {silent = true})

-- undotree
-- keymap('n', ']', ':UndotreeToggle<CR>', {silent = true})

-- telescope
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader><space>', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

-- telescope file browser
keymap('n', '<leader>fb', ':Telescope file_browser', { noremap = true })
-- keymap('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true', { noremap = true })
vim.keymap.set('n', '<leader> ', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

-- telescope file browser
keymap('n', '<space>fb', ':Telescope file_browser', { noremap = true })

-- nvim.ufo (folding)
vim.keymap.set('n', '<leader>fo', ':foldopen<CR>', {silent = true})
vim.keymap.set('n', '<leader>fc', ':foldclose<CR>', {silent = true})

-- telescope-simulators.nvim
vim.keymap.set('n', '<leader>sim', ':Telescope simulators run<CR>', {silent = true})
