#!/bin/bash
#
# Installs Hyprland on Arch distros.

# yay -S gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus hyprlang hyprcursor hyprwayland-scanner xcb-util-errors

hyprland::install-dependencies() {
    local dependencies=(
        "gdb"
        "ninja"
        "gcc"
        "cmake"
        "meson"
        "libxcb"
        "xcb-proto"
        "xcb-util"
        "xcb-util-keysyms"
        "libxfixes"
        "libx11"
        "libxcomposite"
        "xorg-xinput"
        "libxrender"
        "pixman"
        "wayland-protocols"
        "cairo"
        "pango"
        "seatd"
        "libxkbcommon"
        "xcb-util-wm"
        "xorg-xwayland"
        "libinput"
        "libliftoff"
        "libdisplay-info"
        "cpio"
        "tomlplusplus"
        "hyprlang"
        "hyprcursor"
        "hyprutils"
        "hyprwayland-scanner"
        "xcb-util-errors"
    )
    
    # install build dependencies
    for d in "${dependencies[@]}"; do
        paru -Syuq --needed --noconfirm "$d"
    done
}

hyprland::clone-repo() {
    local src="https://github.com/hyprwm/Hyprland"
    local dst="$HOME/src/Hyprland"

    if [[ ! -d "$(dirname "$dst")" ]]; then
        mkdir -p "$(dirname "$dst")"
    fi

    if [[ ! -d "$dst" ]]; then
        git clone --recursive "$src" "$dst"
    fi
}

hyprland::compile() {
    local src="$HOME/src/Hyprland"
    cd "$src" || exit 1
    make all
}

hyprland::main() {
    local src="$HOME/src/Hyprland"

    hyprland::install-dependencies
    hyprland::clone-repo
    hyprland::compile

    cd "$src" || exit 1
    sudo make install
}
hyprland::main
