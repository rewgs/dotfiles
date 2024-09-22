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
    "flatpak"
    "foot"
    "fuzzel"
    "fwupd" # great utility for updating/managing hardware firmware
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
    "luarocks"
    "lynx"
    "make"
    "ncdu"
    "neofetch"
    "net-tools"
    "nmap"
    "nnn" # cli file manager
    "obsidian"
    "openvpn" # required for ProtonVPN
    "pass"
    "picom"
    "podman"
    "qemu-full"
    "qt6-base"
    "qtcreator"

    # AMAZING package -- finds the fastest `n` mirrors for pacman. 
    # Be sure to integrate with systemd:
    # `sudo systemctl enable reflector.timer`
    # `sudo systemctl start reflector.timer`
    "reflector" 
    "ranger" # cli file manager
    "ripgrep"
    "samba"
    "shellcheck" # not available for ARM
    "signal-desktop"
    "sshfs"
    "tailscale" # run `sudo systemctl enable --now tailscaled` to start, and then `sudo tailscale up` and `sudo tailscale up --ssh`
    # "tgt"
    "thefuck"
    "thunderbird"
    "tldr"
    "tree"
    "unzip"
    "vifm" # cli file manager
    "vim"
    "wireguard-tools" # required for ProtonVPN
    "wl-clipboard" # dead simple clipboard utility for Wayland-based window managers; https://github.com/bugaevc/wl-clipboard
    "wget"
    "xorg"
    "zip"
    "zsh"
)
