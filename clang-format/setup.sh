#!/bin/bash
#
# Symlinks `.clang-format` to `~/.clang-format`.

function setup-clang-format::main() {
    local src="$(dirname "$(realpath "${BASH_SOURCE}")")/.clang-format"
    local dst="${HOME}/.clang-format"

    if [[ -f "$dst" ]] || [[ -L "$dst" ]]; then
        rm -f "$dst"
    fi

    if [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}

setup-clang-format::main
