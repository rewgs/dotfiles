#!/bin/bash
#
# Symlinks `$DOTFILES/wezterm/dots` to `~/.config/wezterm`.

setup-wezterm::main() {
    local src="$(realpath $(dirname $BASH_SOURCE))/dots"
    local dst="$HOME/.config/wezterm"

    if [[ ! -d "$(dirname "$dst")" ]]; then
        mkdir -p "$(dirname "$dst")"
    fi

    if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
        rm -rf "$dst"
    fi

    if [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}
setup-wezterm::main
