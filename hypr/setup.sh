#!/bin/bash
#
# Symlinks `dots` to `~/.config/hypr`.

setup-hypr::main() {
    local src="$(realpath $(dirname "${BASH_SOURCE}"))/dots"
    local dst="$HOME/.config/hypr"

    if [[ ! -d "$(dirname "$dst")" ]]; then
        mkdir "$(dirname "$dst")"
    fi

    if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
        rm -rf "$dst"
    fi

    if [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}
setup-hypr::main
