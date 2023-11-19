declare -r -a packages
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
    "git"
    "glances"
    "gnupg2"
    "golang-go"
    "hsetroot"
    "htop"
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
declare -r -a third_party_ppas
third_party_ppas=(
    "nschloe/waybar" # status bar for swaywm; uses X11 though, not Wayland
)

declare -r -a ppa_packages
ppa_packages=(
    "waybar"
)
