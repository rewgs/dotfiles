#!/bin/bash
#
# Symlinks `dots` dir to `~/.config/powershell`

src="$(dirname "$(realpath "${BASH_SOURCE}")")/dots"
dst="$HOME/.config/powershell"

if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
    rm -rf "$dst"
fi

if [[ ! -L "$dst" ]]; then
    ln -s "$src" "$dst"
fi
