#!/bin/bash
#
# Installs build dependencies, clones tmux git repo, symlinks config files.


THIS_DIR=$(realpath $(pwd)) # common
SRC="$HOME/src"
TMUX_SRC="$SRC/tmux"


tmux::install-build-dependencies () {
	cd "$THIS_DIR" || return

	local UNIX_DIR=$(realpath $(dirname "$THIS_DIR"))
	local GET_DISTRO_SCRIPT=$(realpath "$UNIX_DIR/linux/utils/get-distro.sh")
	local DISTRO=$("$GET_DISTRO_SCRIPT")

    apt_deps=(
        "automake"
        "bison"
        "byacc"
        "libevent-dev"
        "ncurses-dev"
    )

    pacman_deps=(
	    "automake"
	    "bison"
	    "byacc"
	    "libevent"
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


tmux::clone-repo () {
    cd "$THIS_DIR" || return

    local REPO="https://github.com/tmux/tmux.git"

	if [[ ! -d "$SRC" ]]; then 
		mkdir "$SRC"; 
	fi

	if [[ ! -d "$TMUX_SRC" ]]; then 
		git clone --depth 1 "$REPO" "$TMUX_SRC"
	fi
}


tmux::update-and-compile () {
	if [[ ! -d "$TMUX_SRC" ]]; then
		tmux::clone-repo
	fi

	cd "$TMUX_SRC" || return

    git pull
    sh autogen.sh

    if [[ $(uname) == "Darwin" ]]; then
        ./configure --enable-utf8proc
    elif [[ $(uname) == "Linux" ]]; then
        ./configure
    fi

    make
}


tmux::install-tpm () {
	local REPO="https://github.com/tmux-plugins/tpm.git"
	local TPM_SRC="$SRC/tpm"
    local DST="$HOME/.tmux/plugins"

	if [[ ! -d "$TPM_SRC" ]]; then
		git clone --depth 1 "$REPO" "$TPM_SRC"
	fi

	if [[ ! -d "$DST" ]]; then
		mkdir -p "$DST"
	fi
	
	if [[ ! -L "$DST/tpm" ]]; then
		ln -s "$TPM_SRC" "$DST/tpm"
	fi
}


tmux::build-from-source () {
	tmux::clone-repo
	tmux::update-and-compile
}


tmux::install-from-source () {
    tmux::install-build-dependencies
    tmux::build-from-source

    cd "$TMUX_SRC" || return
    sudo make install
}


tmux::symlink-dotfiles () {
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


tmux::main () {
    tmux::tmux
    tmux::install-tpm
    tmux::symlink-dotfiles
}
tmux::main
