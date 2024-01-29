#!/bin/bash


install_paru () {
    # installs according to the instructions here:
    # https://github.com/Morganamilo/paru

    sudo pacman -S --needed base-devel

    if [[ ! -d "$HOME/src" ]]; then
        mkdir "$HOME/src"
    fi

    cd "$HOME/src" || return
    git clone https://aur.archlinux.org/paru.git
    cd "$HOME/src/paru" || return
    makepkg -si
}
install_paru
