#!/bin/bash
#
# Symlinks dots dir to ~/.config/weechat

function main() {
    local src="$(realpath "$(dirname "${BASH_SOURCE}")"/dots)"
    local dst="$HOME/.config/weechat"

    if [[ -d "$dst" ]]; then
        rm -rf "$dst"
    fi

    if [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi

    return 0
}
main
