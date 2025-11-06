#!/bin/bash
#
# Symlinks the `dots` dir to `~/.config/alacritty`.
# NOTE: This will silently delete `~/.config/alacritty` (whether it is a directory or symlink)!

function main {
    local src="$(realpath "$(dirname "${BASH_SOURCE}")/dots")"
    local dst="$HOME/.config/alacritty"

    if [[ -d "$dst" ]]; then
        rm -rf "$dst"
    fi

    if [[ ! -d "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}
main
