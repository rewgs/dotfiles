declare -a packages 
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
    "discord"
    "docker"
    "docker-compose"
    "element-desktop"
    "foot"
    "fuzzel"
    "fzf"
    "git"
    "github-cli"
    "glances"
    # "gnu-ncat"
    "gnupg"
    "go"
    "hsetroot"
    "htop"
    "lf"
    "libvirt"
    "llvm"
    "lua"
    "lynx"
    "make"
    "ncdu"
    "neofetch"
    "net-tools"
    "nmap"
    "obsidian"
    "picom"
    "qemu-full"
    "qt6-base"
    "qtcreator"

    # AMAZING package -- finds the fastest `n` mirrors for pacman. 
    # Be sure to integrate with systemd:
    # `sudo systemctl enable reflector.timer`
    # `sudo systemctl start reflector.timer`
    "reflector" 

    "ripgrep"
    "samba"
    "shellcheck" # not available for ARM
    "signal-desktop"
    "tailscale" # run `sudo systemctl enable --now tailscaled` to start, and then `sudo tailscale up` and `sudo tailscale up --ssh`
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