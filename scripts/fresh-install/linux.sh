#!/bin/sh


install_oh_my_zsh () {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


install_lazygit () {
    if [[ if -d $HOME/src ]]; then cd $HOME/src; fi
    git clone git@github.com:jesseduffield/lazygit.git
    cd lazygit
    go install
}


install_tmux_from_source () {
    # install dependencies
    sudo apt install -y \
        bison \
        byacc \
        libevent-dev \

    if [[ if -d $HOME/src ]]; then cd $HOME/src; fi
    git clone git@github.com:tmux/tmux.git
    cd tmux
    sh autogen.sh
    ./configure && make
    sudo make clean install
}


apt_installations () {
    sudo apt update && sudo apt upgrade -y

    sudo apt install \
        bettercap \
        build-essential \
        cmatrix \
        cowsay \
        curl \
        git \
        htop \
        lua \
        tldr \
        wget

    sudo apt update && sudo apt upgrade -y
}
