#!/bin/bash
#
# Clones the zsh-syntax-highlighting repo to $HOME/src.

zsh-syntax-highlighting::main() {
    local repo="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    local src="$HOME/src"
    local dst="$src/zsh-syntax-highlighting"

    if [[ ! -d "$src" ]] || [[ ! -L "$src" ]]; then
        mkdir -p "$src"
    fi

    if [[ ! -d "$dst" ]] || [[ ! -L "$dst" ]]; then
        git clone "$repo" "$dst"
    fi
}
zsh-syntax-highlighting::main
