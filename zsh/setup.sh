#!/bin/bash
#
# Setups up all zsh dotfiles, as well as oh-my-zsh.

# Symlinks:
#   $DOTFILES/zsh/dots/zlogin   -> ~/.zlogin
#   $DOTFILES/zsh/dots/zlogout  -> ~/.zlogout
#   $DOTFILES/zsh/dots/zprofile -> ~/.zprofile
#   $DOTFILES/zsh/dots/zshenv   -> ~/.zshenv
#   $DOTFILES/zsh/dots/zshrc    -> ~/.zshrc
setup-zsh() {
    dots="$(realpath "$(dirname "$BASH_SOURCE")"/dots)"
    for item in "$dots"/*; do
        name="$(basename "$item")"

        if [[ -f "$item" ]]; then
            dst="$HOME/.$name"
            if [[ -f "$dst" ]] || [[ -L "$dst" ]]; then
                rm -f "$dst"
            fi

            ln -s "$item" "$dst"
        fi
    done
}
setup-zsh
