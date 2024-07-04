#!/bin/bash
#
# Installs build dependencies, clones neovim git repo, symlinks config files.


THIS_DIR=$(realpath $(pwd)) # common
SRC="$HOME/src"
NEOVIM_SRC="$SRC/neovim"


nvim::install-build-dependencies () {
	cd "$THIS_DIR" || return

	local UNIX_DIR=$(realpath $(dirname "$THIS_DIR"))
	local GET_DISTRO_SCRIPT=$(realpath "$UNIX_DIR/linux/utils/get-distro.sh")
	local DISTRO=$("$GET_DISTRO_SCRIPT")

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

	pacman_deps=(
		"base-devel"
		"cmake"
		"curl"
		"ninja"
		"unzip"
	)

	if [[ "$DISTRO" == *"Debian"* ]] || [[ "$DISTRO" == *"Ubuntu"* ]]; then
		for d in "${apt_deps[@]}"; do
			sudo apt-get install -y "$d"
		done
	elif [[ "$DISTRO" == *"Arch"* ]]; then
		for d in "${pacman_deps[@]}"; do
			sudo pacman -Syuq --needed --noconfirm "$d"
		done
	fi
}


nvim::clone-repo () {
	cd "$THIS_DIR" || return

	local REPO="https://github.com/neovim/neovim.git"

	if [[ ! -d "$SRC" ]]; then 
		mkdir "$SRC"; 
	fi

	if [[ ! -d "$NEOVIM_SRC" ]]; then 
		git clone --depth 1 "$REPO" --branch stable "$NEOVIM_SRC"
	fi
}


nvim::update-and-compile () {
	if [[ ! -d "$NEOVIM_SRC" ]]; then
		nvim::clone-repo
	fi

	cd "$NEOVIM_SRC" || return

	git checkout stable
	git pull

	# FIXME: I think these two blocks need to look for more than just the `cmake.debs` dir. 
	# TODO: What else does the `make CMAKE_BUILD_TYPE=RelWithDebInfo` command create? Find out 
	# test for it in the following conditional blocks.
	# if [[ -d "$NEOVIM_SRC/cmake.deps" ]]; then
	# 	sudo rm -rf "$NEOVIM_SRC/cmake.deps"
	# fi
	# 
	# if [[ ! -d "$NEOVIM_SRC/cmake.deps" ]]; then
	# 	make CMAKE_BUILD_TYPE=RelWithDebInfo
	# fi

	make CMAKE_BUILD_TYPE=RelWithDebInfo
}


nvim::install-packer-nvim () {
	local REPO="https://github.com/wbthomason/packer.nvim"
	local DST="$HOME/.local/share/nvim/site/pack/packer/start"
	local PACKER_SRC="$DST/packer.nvim"

	if [[ ! -d "$DST" ]]; then
		mkdir -p "$DST"
	fi
	
	if [[ ! -d "$PACKER_SRC" ]]; then
		git clone --depth 1 "$REPO" "$PACKER_SRC"
	fi
	
	if [[ ! -L "$DST/packer.nvim" ]]; then
		ln -s "$PACKER_SRC" "$DST"
	fi
}


nvim::build-from-source () {
	nvim::clone-repo
	nvim::update-and-compile
}


nvim::install-from-source () {
    nvim::install-build-dependencies
    nvim::build-from-source

    cd "$NEOVIM_SRC" || return
    sudo make clean install
}


nvim::symlink-dotfiles () {
	cd "$THIS_DIR" || return
	# echo "This dir: $THIS_DIR"

	local DOTFILES=$(realpath $(dirname $(
		realpath $(dirname $(
			realpath $(dirname $(
				realpath $(dirname "$THIS_DIR"))
				)
			))
		))
	)
	# echo "Dotfiles: $DOTFILES"

	local SETUP_SCRIPT=$(realpath "$DOTFILES/nvim/setup.sh")
	# echo "Setup script: $SETUP_SCRIPT"

	. "$SETUP_SCRIPT" "$DOTFILES"
}


nvim::main () {
	nvim::install-from-source
	nvim::install-packer-nvim
	nvim::symlink-dotfiles
}
nvim::main
