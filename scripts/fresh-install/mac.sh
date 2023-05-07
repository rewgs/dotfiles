#!/bin/sh


# ssh keys
# github


install_homebrew () { 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}


install_oh_my_zsh () {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


install_xcode_command_line_tools () {
    xcode-select --install
}


homebrew_installations () {
    brew update && brew upgrade -y

    brew tap \
        homebrew/cask-fonts

    brew install \
        bettercap \
        --cask font-fira-code-nerd-font \
        git \
        jesseduffield/lazygit/lazygit \
        neofetch
}


mac_fresh_install () {
    install_homebrew
    install_xcode_command_line_tools
    install_oh_my_zsh
}
 
mac_fresh_install 
