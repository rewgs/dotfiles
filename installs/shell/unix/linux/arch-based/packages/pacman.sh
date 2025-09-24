packages=(
    # NOTE: Commented-out packages are incorrect package names.
    "apache"
    "arp-scan"
    "automake"
    "base-devel" # equivalent to apt's built-essential
    "bettercap"
    "bpytop"
    "brightnessctl" # for using media keys to control brightness
    "btop"
    "cmake"
    "cmatrix"
    "cowsay"
    "curl"
    "discord"
    "docker"
    "docker-compose"
    "element-desktop"
    "fastfetch"
    "feh" # image viewer
    "firefox"
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
    "less" # can't believe this isn't installed by default!
    "lf"
    "libvirt"
    "llvm"
    "lua"
    "luarocks"
    "lynx"
    "make"
    "man-db" # for reading man pages. Yes, this is actually required.
    "ncdu"
    "neofetch"
    "net-tools"
    "networkmanager" # nmcli, nmtui
    "nmap"
    "nnn"      # cli file manager
    "nwg-look" # GTK settings manager for wayland environments
    "obsidian"
    "openvpn" # required for ProtonVPN
    "pacman-contrib" # includes some nice quality-of-life scripts, such as `checkupdates`
    "pamixer" # used by hypr to control volume
    "pass"
    "pavucontrol" # for controlling volume via media keys
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
    "sxiv"      # image viewer
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
    "wl-clipboard"    # dead simple clipboard utility for Wayland-based window managers; https://github.com/bugaevc/wl-clipboard
    "wget"
    "xbindkeys"
    "xorg"
    "zip"
    "zsh"
)

function pacman::main() {
    sudo pacman -Syu
    for package in "${packages[@]}"; do
        sudo pacman -Sy --needed "$package" --noconfirm
    done
}
pacman::main
