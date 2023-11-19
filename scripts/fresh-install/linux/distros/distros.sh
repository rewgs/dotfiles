declare -r -a _apt_distros
_apt_distros=(
    "Debian"
    "Ubuntu"
)

declare -r -a _pacman_distros
_pacman_distros=(
    "Arch"
    "Manjaro"
)

function get_distro () {
    ( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1
}
