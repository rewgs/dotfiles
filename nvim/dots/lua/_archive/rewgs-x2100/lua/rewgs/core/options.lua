-- NOTE: most of this file comes from https://www.youtube.com/watch?v=6pAG3BHurdM

vim.cmd("let g:netrw_liststyle = 3")    -- Changes netrw (Vim's built-in file browser) style to "3," kind of a "tree" mode.

-- line numbers
vim.opt.relativenumber = true               -- Enables relative line numbers.
vim.opt.number = true 		                -- Ensures that the current line number is absolute, even with relative line numbers enabled.

-- tabs & indentation
vim.opt.tabstop = 4			                -- Tab = 4 spaces.
vim.opt.shiftwidth = 4		                -- Indent width = 4 spaces.
vim.opt.expandtab = true 	                -- Expand tab to spaces.
vim.opt.autoindent = true	                -- Copy indent from current line when starting new line.

-- search settings
vim.opt.ignorecase = true                   -- Ignore case when searching.
vim.opt.smartcase = true                    -- If search query includes mixed case, case-sensitive searching is temporarily enabled.

-- colors
vim.opt.termguicolors = true                -- Required for most color schemes to work correctly.
vim.opt.background = "dark"                 -- Colorschemes that have both light and dark modes will be dark by default.
vim.opt.signcolumn = "yes"                  -- Show sign column/gutter so that text doesn't shit (Not sure what this means?)

-- editing
vim.opt.backspace = "indent,eol,start"      -- Allow backspace on indent, end of line, or insert mode start position.

-- clipboard
vim.opt.clipboard:append("unnamedplus")     -- Use system clipboard as default register.

-- buffers
vim.opt.splitright = true                   -- Split new vertical buffers to the right.
vim.opt.splitbelow = true                   -- Split new horizontal buffers to the bottom.

-- misc
vim.opt.wrap = false                        -- Disables line wrapping.
vim.opt.cursorline = false                  -- Included for reference, even though false is default.
-- vim.opt.noswapfile = true
-- vim.opt.nobackup = true
vim.opt.shortmess:append("c")               -- Removes the start screen.
vim.opt.errorbells = false                  -- Turns off error bells.
