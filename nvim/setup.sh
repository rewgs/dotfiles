#!/bin/bash
#
# Symlinks `dots` to `~/.config/nvim`.


nvim-setup::main() {
    local src="$(realpath "$(dirname "$BASH_SOURCE")"/dots)"
    local dst="$HOME/.config/nvim"

    if [[ ! -d "$(dirname "$dst")" ]]; then
        mkdir "$(dirname "$dst")"
    fi

    if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
        rm -rf "$dst"
    fi

    if [[ ! -d "$dst" ]] || [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}
