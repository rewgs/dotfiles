#!/bin/bash
#
# Symlinks zellij dotfiles.

setup::main() {
    local SRC="$(realpath $(dirname $BASH_SOURCE))/dots"
    local DST="$HOME/.config/zellij"

    if [[ ! -d "$(dirname $DST)"]]; then mkdir "$(dirname $DST)"; fi
    if [[ -d "$DST" ]] || [[ -L "$DST" ]]; then
        sudo rm -rf "$DST"
    fi
    if [[ ! -L "$DST" ]]; then
        ln -s "$DST" "$DST"
    fi
}
setup::main
