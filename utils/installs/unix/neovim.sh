#!/usr/bin/bash

build_neovim_from_source () {
	if [[ ! -d "$HOME/src" ]]; then mkdir "$HOME/src"; fi
    cd "$HOME/src" || return

    if [[ ! -d "$HOME/src/neovim" ]]; then 
    	git clone --depth 1 https://github.com/neovim/neovim.git --branch stable
	fi
    cd "$HOME/src/neovim" || return

    git checkout stable
    git pull

    if [[ ! -d "$HOME/src/neovim/cmake.deps" ]]; then
    	make CMAKE_BUILD_TYPE=RelWithDebInfo
	fi
    sudo make install
}


install_neovim_build_dependencies () {
	typeset -a apt_deps
	apt_deps=(
		"autoconf"
		"automake"
		"cmake"
		"doxygen"
		"g++"
		"gettext"
		"libtool"
		"libtool-bin"
		"ninja-build"
		"pkg-config"
		"unzip"
	)

	typeset -a pacman_deps
	pacman_deps=(
		"base-devel"
		"cmake"
		"curl"
		"ninja"
		"unzip"
	)

	this_dir="$(dirname "$(readlink -f "$0")" )"
	. "$this_dir/distros.sh"

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


install_neovim_from_source () {
	install_neovim_build_dependencies
	build_neovim_from_source
}


update_neovim_from_source () {
	cd "$HOME"/src/neovim || return
	git checkout stable
	git pull
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make clean install
}



install_packer_nvim () {
    if [[ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/" ]]; then
        mkdir -p "$HOME/.local/share/nvim/site/pack/packer/start/"
    fi

    if [[ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim" ]]; then
	git clone --depth 1 \
        https://github.com/wbthomason/packer.nvim \
        "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
fi
}


main () {
	install_neovim_from_source
	install_packer_nvim
}
# main
