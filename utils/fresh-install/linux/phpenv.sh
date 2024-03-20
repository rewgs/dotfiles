#!/bin/bash

# FIXME: Need to make sure this script can see `get_distro()`
install_phpenv_build_dependencies () {
    typeset -a apt_deps
    apt_deps=(
        "apache2-dev"
        "libcurl4-gnutls-dev"
        "libjpeg-dev"
        "libonig-dev"
		"libssl-dev"
        "libtidy-dev"
        "libzip-dev"
        "re2c"
    )

    typeset -a pacman_deps
    pacman_deps=(
        "libxslt"
        "libzip"
        "oniguruma"
        "tidy"
        "re2c"
    )

	. "$1/distros.sh"
	if [[ $(get_distro) == *"Debian"* ]] || [[ $(get_distro) == *"Ubuntu"* ]]; then
		for d in "${apt_deps[@]}"; do
			sudo apt-get install -y "$d"
		done
	elif [[ $(get_distro) == *"Arch"* ]]; then
		for d in "${pacman_deps[@]}"; do
			sudo pacman -Syuq --needed --noconfirm "$d"
		done
	fi
}


get_phpenv_src () {
    if [[ ! -d "$HOME/src" ]]; then 
        mkdir "$HOME/src" 
    fi
    cd "$HOME/src" || return

    if [[ ! -d "$HOME/src/phpenv" ]]; then
        git clone --depth 1 https://github.com/phpenv/phpenv.git
    fi
}


get_phpbuild_src () {
    if [[ ! -d "$HOME/src" ]]; then 
        mkdir "$HOME/src" 
    fi
    cd "$HOME/src" || return

    if [[ ! -d "$HOME/src/php-build" ]]; then
        git clone --depth 1 https://github.com/php-build/php-build.git
    fi
}

install_phpenv_from_source () {
    get_phpenv_src
    get_phpbuild_src

	. "$1/symlink_dotfiles.sh"
    symlink_phpenv
    symlink_phpbuild
}


main () {
	this_dir="$(dirname "$(readlink -f "$0")" )"

    install_phpenv_build_dependencies "$this_dir"
    install_phpenv_from_source "$this_dir"
}
main

main
