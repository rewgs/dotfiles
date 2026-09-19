#!/bin/bash
#
# Symlinks dots dir to ~/.config/poem

src="$(realpath $(dirname $BASH_SOURCE)/dots)"
dst="$HOME/.config/poem"

if [[ -d "$dst" ]]; then
    rm -rf "$dst"
fi

if [[ ! -d "$dst" ]] || [[ ! -L "$dst" ]]; then
    echo "Symlinks $src to $dst"
    ln -s "$src" "$dst"
fi
