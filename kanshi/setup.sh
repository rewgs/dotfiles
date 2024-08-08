#!/bin/bash
#
# Symlinks $DOTFILES/kanshi/dots to ~/.config/kanshi

setup-kanshi::main() {
    local SRC="$(realpath $(dirname $BASH_SOURCE))/dots"
    local DST="$HOME/.config/kanshi"

    if [[ ! -d "$(dirname "$DST")" ]]; 
        then mkdir -p "$(dirname "$DST")"; 
    fi

    if [[ -d "$DST" ]]; 
        then rm -rf "$DST"; 
    fi

    if [[ ! -L "$DST" ]]; 
        then ln -s "$SRC" "$DST"; 
    fi
}
setup-kanshi::main
