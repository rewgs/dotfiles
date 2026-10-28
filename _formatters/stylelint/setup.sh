#!/bin/bash
#
# Symlinks `stylelintrc.json` to ~/.config/stylelint/stylelintrc.json.
# This acts as a global stylelint config in case the current project doesn't have one.

setup::main() {
    local src
    local name
    local dst_dir
    local dst

    src="$(realpath "$(dirname "${BASH_SOURCE}")"/stylelintrc.json)"
    name="$(basename "$src")"

    dst_dir="${HOME}/.config/stylelint"
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
