#!/usr/bin/bash


build_tmux_from_source () {
    cd "$HOME"/src/tmux
    git pull
    sh autogen.sh
    ./configure && make
    sudo make install
}


install_tmux_from_source () {
    typeset -a apt_deps
    apt_deps=(
        "automake"
        "bison"
        "byacc"
        "libevent-dev"
        "ncurses-dev"
    )

    typeset -a pacman_deps
    pacman_deps=(
	    "automake"
	    "bison"
	    "byacc"
	    "libevent"
	)

    this_dir="$(dirname "$(readlink -f "$0")" )"
    . "$this_dir/distros.sh"

    if [[ $(get_distro) == *"Debian"* ]] || [[ $(get_distro) == *"Ubuntu"* ]] ; then
        for d in "${apt_deps[@]}"; do
            sudo apt-get install -y "$d"
        done
    elif [[ $(get_distro) == *"Arch"* ]] ; then
        for d in "${pacman_deps[@]}"; do
            sudo pacman -Syuq --noconfirm "$d"
        done
    fi

    if [[ ! -d "$HOME"/src ]]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src

    git clone --depth 1 https://github.com/tmux/tmux.git

    build_tmux_from_source
}


install_tmux_package_manager () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/tmux-plugins/tpm.git

    if [ ! -d "$HOME"/.tmux/plugins ]; then mkdir -p "$HOME"/.tmux/plugins; fi
    ln -s "$HOME"/src/tpm "$HOME"/.tmux/plugins/tpm
}

main () {
	install_tmux_from_source
	install_tmux_package_manager
}
main
