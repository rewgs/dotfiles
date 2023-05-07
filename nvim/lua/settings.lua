local a = vim.api
local g = vim.g
local o = vim.opt

-- indentation
o.tabstop = 4               -- Dictates the width used to display an actual tabulation character (\t).
o.softtabstop = 0           -- Dictates how wide an indentation is supposed to span.             The special values of 0 means to replicate the value of 'tabstop'.
o.shiftwidth = 0            -- Sets the width used for shifting commands, such as <<, >>, or ==. The special value of 0 means to replicate the value of 'tabstop'.
o.expandtab = true          -- Inserts spaces (equal to the number set in tabstop, etc) when tabbing
o.autoindent = true         -- Adds indents automatically
o.smartindent = true        -- ^...in a way that mostly works correctly most of the time

-- search and commands
o.ignorecase = true         -- Allows invoking commands, case-insensitive (i.e. type :nerdtree for :NERDTree)
o.smartcase = false         -- If ^ is enabled, a search is case-sensitive only if it contains a capital letter
o.incsearch = true          -- Enables incremental search
o.hlsearch = true           -- Highlights searche results

-- line numbers
o.number = true             -- Activates line numbers
o.relativenumber = true     -- Turn hybrid line numbers on

-- misc
o.shortmess:append('c')     -- Removes the start screen
o.errorbells = false        -- Turns off error bells
-- o.noswapfile = true
-- o.nobackup = true
-- o.virtualedit = all      -- Makes it so that, when navigating up and down, the cursor stays in the same column.

-- wrapping
o.wrap = false
o.textwidth = 0

-- clipboard
-- unifies nvim and system clipboard on macOS
o.clipboard = 'unnamedplus'
