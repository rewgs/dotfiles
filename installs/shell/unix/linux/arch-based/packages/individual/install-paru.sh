#!/bin/bash

# installs according to the instructions here:
# https://github.com/Morganamilo/paru
install-paru::main() {
    local src="https://aur.archlinux.org/paru.git"
    local dst="$HOME/src/paru"

    dependencies=(
        "base-devel"
    )

    for d in "${dependencies[@]}"; do
        sudo pacman -Sy --needed --noconfirm "$d"
    done

    if [[ ! -d "$(dirname "$dst")" ]]; then
        mkdir "$(dirname "$dst")"
    fi

    if [[ ! -d "$dst" ]]; then
        git clone "$src" "$dst"
    fi

    cd "$HOME/src/paru" || return
    makepkg -si
}
install-paru::main
