declare -r -a apt_distros
apt_distros=(
    "Debian"
    "Ubuntu"
)

declare -r -a pacman_distros
pacman_distros=(
    "Arch"
    "Manjaro"
)

function get_distro () {
    ( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1
}
