get_package_manager () {
    distro="$1"
    package_manager=""

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
            package_manager="apt"
            echo "$package_manager"
        fi
    done

    for p in "${pacman_distros[@]}"; do
        if [[ "$distro" == *"$p"* ]]; then
            package_manager="pacman"
            echo "$package_manager"
        fi
    done
}

update_packages () {
    package_manager="$1"
    echo "Checking for updates..."

    if [[ "$package_manager" == "apt" ]]; then
        if [[ $(apt-get update -qq) -eq 0 ]]; then
	    	echo "Upgrading packages..."
            # note: NEEDRESTART_SUSPEND=1 is required in Ubuntu 22.04 LTS in order to prevent a 
            # prompt which asks the user which service(s) should be restarted, if any.
	    	# NEEDRESTART_SUSPEND=1 apt-get upgrade -qq -y
	    	sudo apt-get upgrade -qq -y
	    fi
    elif [[ "$package_manager" == "pacman" ]]; then
        if [[ $(pacman -Syq) -eq 0 ]]; then
	    	echo "Upgrading packages..."
            # the `--needed` flag maybe makes this conditional unnecessary?
            sudo pacman -Syuq --needed --noconfirm
	    fi
    else
        echo "Package manager $package_manager is not supported!"
    fi
}

install_packages () {
    this_dir="$1"
    . "$this_dir/distros.sh"

    cd "$this_dir" || return
    package_manager=$(get_package_manager "$(get_distro)" )
    # echo "$distro uses package manager $package_manager"
    update_packages "$package_manager"

    echo "Installing packages..."
    if [[ "$package_manager" == "apt" ]]; then
        . packages/apt_packages.sh
        for p in "${packages[@]}"; do
            # note: NEEDRESTART_SUSPEND=1 is required in Ubuntu 22.04 LTS in order to prevent a 
            # prompt which asks the user which service(s) should be restarted, if any.
            # NEEDRESTART_SUSPEND=1 apt-get install -y "$a"
            sudo apt-get install -y "$p"
    	        # > /dev/null 2> /dev/null # for some reason, `&> /dev/null` isn't silent, but this is
        done

        for p in "${third_party_ppas[@]}"; do
            sudo add-apt-repository ppa:"$p"
        done

        update_packages "$package_manager"

        for p in "${ppa_packages[@]}"; do
            sudo apt-get install -y "$p"
        done

    elif [[ "$package_manager" == "pacman" ]]; then
        . packages/pacman_packages.sh
        for p in "${packages[@]}"; do
            # `pacman -Q` queries the installed local package database; `-i` returns information on the package.
            # If exit code is 0, package is installed; otherwise, it's not.
            if [[ ! $(pacman -Qi "$p") ]]; then
                sudo pacman -Syuq --noconfirm "$p"
            fi
        done

        echo "Installing packages via the AUR..."
        for p in "${aur_packages[@]}"; do
            sudo paru -Syuq --noconfirm "$p"
        done
    else
        echo "Package manager $package_manager is not supported!"
    fi

    echo "Package manager basic installations complete!"
}