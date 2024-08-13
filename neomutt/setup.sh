#!/bin/bash
#
# Sets up neomutt dotfiles.

neomutt-setup::main() {
    local src="$(realpath $(dirname ${BASH_SOURCE}))/dots"
    local dst="$HOME/.config/neomutt"

    # echo "src: $src"
    # echo "dst: $dst"

    if [[ -d "$dst" ]] || [[ -L "$dst" ]]; 
        then rm -rf "$dst"; 
    fi

    if [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}
neomutt-setup::main
