#!/bin/bash
#
# Symlinks $DOTFILES/wezterm/dots to ~/.config/wezterm

setup-wezterm::main() {
    local SRC="$(realpath $(dirname $BASH_SOURCE))/dots"
    local DST="$HOME/.config/wezterm"

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
setup-wezterm::main
