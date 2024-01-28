#!/bin/bash


# FIXME: Need to make sure this script can see `get_distro()`
install_pyenv_build_dependencies () {
	typeset -a apt_deps
	apt_deps=(
		"build-essential"
		"libssl-dev"
		"zlib1g-dev"
		"libbz2-dev"
		"libreadline-dev"
		"libsqlite3-dev"
		"curl"
		"libncursesw5-dev"
		"xz-utils"
		"tk-dev"
		"libxml2-dev"
		"libxmlsec1-dev"
		"libffi-dev"
		"liblzma-dev"
    )

    typeset -a pacman_deps
    pacman_deps=(
        "base-devel"
        "openssl"
        "zlib"
        "xz"
        "tk"
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



install_pyenv_from_source () {
    if [[ ! -d "$HOME/src" ]]; then 
        mkdir "$HOME/src"; 
    fi

    cd "$HOME/src" || return

    if [[ ! -d "$HOME/src/pyenv" ]]; then
        git clone --depth 1 https://github.com/pyenv/pyenv.git
    fi

	. "$1/symlink_dotfiles.sh"
    symlink_pyenv
}


main () {
	this_dir="$(dirname "$(readlink -f "$0")" )"
    install_pyenv_build_dependencies "$this_dir"
    install_pyenv_from_source "$this_dir"
}
# main
