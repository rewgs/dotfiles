#!/bin/bash

APT_PACKAGES=(
    "apache2"
    "apt-file" # this is SO useful. `apt-file search "header.h"` will help find the -dev package that contains it.
    "apt-transport-https"
    "arp-scan"
    "automake"
    "bettercap"
    "bpytop"
    "btop"
    "build-essential"
    "cbonsai"
    "cmake"
    "cmatrix"
    "cowsay"
    "curl"
    "docker"
    "docker-compose"
    "fzf"
    "gh"
    "git"
    "glances"
    "gnupg2"
    "golang-go"
    "hsetroot"
    "htop"
    "lf"
    "libvirt-daemon"
    "llvm"
    "lua5.4"
    "lynx"
    "make"
    "ncat"
    "ncdu"
    "neofetch"
    "net-tools"
    "nmap"
    "picom"
    "qemu-kvm"
    "rename"
    "ripgrep"
    "shellcheck"
    "software-properties-common"
    "tgt"
    "thefuck"
    "tldr"
    "tree"
    "unzip"
    "vim"
    "wl-clipboard" # dead simple clipboard utility for Wayland-based window managers; https://github.com/bugaevc/wl-clipboard
    "wget"
    "xorg"
    "zip"
    "zsh"
)

# Due to bash not having nested arrays, the simplest way to keep ppas 
# and packages commands is to put them in separate arrays, add the ppas, 
# then install the packages.
THIRD_PARTY_PPAS=(
    "keithw/mosh-dev" # need to install mosh from this ppa for now in order to get true color support; see here: https://github.com/mobile-shell/mosh/issues/945
    "nschloe/waybar" # status bar for swaywm; uses X11 though, not Wayland
)

PPA_PACKAGES=(
    "waybar"
)
