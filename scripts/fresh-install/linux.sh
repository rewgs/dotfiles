#!/bin/sh


install_oh_my_zsh () {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


install_lazygit () {
    if [[ if -d $HOME/src ]]; then
        cd $HOME/src
        git clone git@github.com:jesseduffield/lazygit.git
        cd lazygit
        go install
    fi
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
        wget \
}
