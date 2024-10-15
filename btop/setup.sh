#!/bin/bash
#
# Symlinks the `dots` directory to `~/.config/btop`.


main() {
    local src="$(realpath "$(dirname "$BASH_SOURCE")/dots")"
    local dst="$HOME/.config/btop"

    local config="$(dirname "$dst")"
    if [[ ! -d "$config" ]]; then
        mkdir -p "$config"
    fi

    if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
        rm -rf "$dst"
    fi

    if [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}
main
