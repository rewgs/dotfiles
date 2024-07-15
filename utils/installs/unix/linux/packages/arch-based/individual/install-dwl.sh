#!/bin/bash
#
# Installs dwl, the Wayland version of suckless dwm.


install-dwl::install-dependencies() {
    local ARCH_DEPENDENCIES=(
        # required
        "libinput"
        "pkgconf"
        "wayland"
        "wayland-protocols"
        "wlroots" # compiled with the libinput backend
        "libxkbcommon"
    
        # required only if X11 support is needed
        "libxcb"
        "wlroots" # compiled with X11 support
        "xcb-util-wm"
        "xorg-xwayland"
    )
    
    for d in "${ARCH_DEPENDENCIES[@]}"; do
        sudo pacman -Syuq --needed --noconfirm "$d"
    done
}


# TODO: 
# - uncomment Xwayland flags in `config.mk`
# - compile/install
install-dwl::main() {
    local SRC="$HOME/src/dwl"

    install-dwl::install-dependencies
}
install-dwl::main
