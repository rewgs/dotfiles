#!/bin/bash

packages=(
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

function apt::main() {
    sudo apt update
    for package in "${packages[@]}"; do
        sudo apt install "$package" -y
    done
}
apt::main
