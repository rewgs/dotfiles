#!/bin/bash
#
# Symlinks directories within `custom` to `~/.oh-my-zsh/custom/`

src="$(realpath "$(dirname "$(realpath "$BASH_SOURCE")")"/custom)"
dst="$HOME/.oh-my-zsh/custom"

for dir in "$src"/*; do
    name="$(basename "$dir")"
    ln -s "$(realpath "$dir")" "$dst/$name"
done
