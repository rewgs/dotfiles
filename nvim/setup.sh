#!/bin/bash
#
# Sets up neovim on Unix systems.
# Symlinks the `$DOTFILES/nvim/dots/${package_manager}` dir to `~/.config/nvim`.


nvim-setup::main() {
    local DOTS="$(realpath $(dirname $BASH_SOURCE))/dots/"
    # echo "$DOTS"

    local SRC="$(realpath $DOTS/$1)"
    # echo "$SRC"

    local DST="$HOME/.config/nvim"

    if [[ ! -d "$(dirname $DST)" ]]; 
        then mkdir -p "$(dirname $DST)"; 
    fi

    if [[ -d "$DST" ]] || [[ -L "$DST" ]]; 
        then rm -rf "$DST"; 
    fi

    if [[ ! -L "$DST" ]]; then
        ln -s "$SRC" "$DST"
    fi
}

nvim-setup::main "$1"
