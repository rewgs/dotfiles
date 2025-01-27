#!/bin/bash
#
# Symlinks `starship.toml` to ~/.config/starship.toml

setup::main() {
    local src
    local name
    local dst_dir
    local dst

    src="$(realpath "$(dirname "${BASH_SOURCE}")"/dots/starship.toml)"
    name="$(basename "$src")"

    dst_dir="${HOME}/.config"
    dst="${dst_dir}/${name}"

    if [[ ! -d "$dst_dir" ]]; then 
        mkdir -p "$dst_dir"
    fi

    if [[ -f "$dst" ]] || [[ -L "$dst" ]]; then 
        rm -f "$dst"
    fi

    if [[ ! -L "$dst" ]]; then 
        ln -s "$src" "$dst"
    fi
}
setup::main
