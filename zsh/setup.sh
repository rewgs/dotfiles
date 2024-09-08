#!/bin/bash
#
# Symlinks:
# dots/zlogin   -> ~/.zlogin
# dots/zlogout  -> ~/.zlogout
# dots/zprofile -> ~/.zprofile
# dots/zshenv   -> ~/.zshenv
# dots/zshrc    -> ~/.zshrc
# dots/conf     -> ~/.config/zsh


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
