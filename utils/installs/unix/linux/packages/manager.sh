get_package_manager () {
    local utils="$DOTFILES/utils/fresh-install/linux/utils.sh"
    source "$utils"
    local distro=$(get_distro)

    declare -a apt_distros
    apt_distros=(
        "Debian"
        "Ubuntu"
    )
    
    declare -a pacman_distros
    pacman_distros=(
        "Arch"
        "Manjaro"
    )

    for a in "${apt_distros[@]}"; do
        if [[ "$distro" == *"$a"* ]]; then
            local package_manager="apt"
        fi
    done

    for p in "${pacman_distros[@]}"; do
        if [[ "$distro" == *"$p"* ]]; then
            local package_manager="pacman"
        fi
    done

    echo "$package_manager"
}
