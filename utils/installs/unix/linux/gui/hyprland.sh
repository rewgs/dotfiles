#!/bin/bash

# install build dependencies
yay -S gdb ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus

# build from source with cmake
cd ~/src || return
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland || return
make all && sudo make install

# symlink config files

