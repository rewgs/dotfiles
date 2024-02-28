function build_tmux_from_source () {
    # for building new and updating
    cd "$HOME"/src/tmux
    git pull
    sh autogen.sh
    ./configure && make

    # apparently there's no 'clean' option?
    # sudo make clean install   
    sudo make install
}


function install_tmux_from_source () {
    typeset -a deps
    deps=(
        "bison"
        "byacc"
        "libevent-dev"
    )

    if [[ $(get_distro) == *"Debian"* ]] || [[ $(get_distro) == *"Ubuntu"* ]] ; then
        for d in "${deps[@]}"; do
            sudo apt-get install -y "$d"
        done
    elif [[ $(get_distro) == *"Arch"* ]] ; then
        for d in "${deps[@]}"; do
            sudo pacman -Syuq --noconfirm "$d"
        done
    fi

    if [ ! -d "$HOME"/src ]; 
        then mkdir "$HOME"/src; 
    fi

    cd "$HOME"/src
    git clone --depth 1 https://github.com/tmux/tmux.git

    build_tmux_from_source
}


function install_tmux_package_manager () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/tmux-plugins/tpm.git

    if [ ! -d "$HOME"/.tmux/plugins ]; then mkdir -p "$HOME"/.tmux/plugins; fi
	ln -s "$HOME"/src/tpm "$HOME"/.tmux/plugins/tpm
}
