declare -r -a packages 
packages=(
    # NOTE: commented-out packages are incorrect package names (as these were copied from 
    # apt script above); need to find correct package name for Pacman
    "apache"
    "arp-scan"
    "automake"
    "base-devel" # equivalent to apt's built-essential
    "bettercap"
    "bpytop"
    "btop"
    "cmake"
    "cmatrix"
    "cowsay"
    "curl"
    "docker"
    "docker-compose"
    "git"
    "glances"
    "gnu-ncat"
    "gnupg"
    "go"
    "hsetroot"
    "htop"
    "libvirt"
    "llvm"
    "lua"
    "lynx"
    "make"
    "ncdu"
    "neofetch"
    "net-tools"
    "nmap"
    # "paru" # Pacman helper; can't install this with Pacman, need to install manually: https://github.com/Morganamilo/paru
    "picom"
    "qemu-full"
    # "shellcheck" # not available for ARM?
    "software-properties-common"
    # "tgt"
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


declare -r -a aur_packages
aur_packages=(
    "cbonsai"
    "xrdp"
)
