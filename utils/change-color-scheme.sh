#!/bin/sh


# Changes the color schemes of neovim (including lualine), tmux, and all terminals.
# Files to change:
#   ~/dotfiles/nvim/lua/color-scheme.lua
#   ~/dotfiles/nvim/lua/plugins/config/lualine.lua
#   ~/dotfiles/tmux/tmux.conf
#   ~/dotfiles/wezterm/wezterm.lua

lua_comment="-- "

# The `-i` flag edits the input file in place (rather than writing to a new file)
# The final `/g` means that the find/replace operates on all instances of the find word
# sed -i 's/find/replace/g' file


