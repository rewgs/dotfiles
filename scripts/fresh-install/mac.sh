#!/usr/bin/env zsh


# ssh keys
# github


function install_homebrew () { 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}


function install_oh_my_zsh () {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


function install_xcode_command_line_tools () {
    xcode-select --install
}


function homebrew_installations () {
    typeset -a brew_apps
    brew_apps=(
        "--cask amethyst"                           # amethyst
        "bettercap"                                 # bettercap
        "--cask blackhole-2ch"                      # blackhole - 2ch
        "--cask blackhole-16ch"                     # blackhole - 16ch
        "bpytop"                                    # bpytop
        "btop"                                      # btop
        "cmatrix"                                   # cmatrix
        "coreutils"                                 # coreutils
        "cowsay"                                    # cowsay
        "--cask firefox"                            # firefox
        "--cask font-fira-code-nerd-font"           # fira code nerd font
        "gh"                                        # github cli
        "git"                                       # git
        "glances"                                   # glances
        "gnu-sed"                                   # gnu sed
        "--cask google-chrome"                      # google chrome
        "htop"                                      # htop
        "jesseduffield/lazygit/lazygit"             # lazygit
        "neofetch"                                  # neofetch
        "--cask reaper"                             # reaper
        "shellcheck"                                # shellcheck
        "brew install koekeishiya/formulae/skhd"    # skhd
        "thefuck"                                   # thefuck
        "tldr"                                      # tldr
        "koekeishiya/formulae/yabai"                # yabai
    )

    typeset -a pyenv_build_dependencies
    pyenv_build_dependencies=(
        "openssl"
        "readline"
        "sqlite3"
        "tcl-tk"
        "xz"
        "zlib"
    )

    typeset -a neovim_build_prerequisites
    neovim_build_prerequisites=(
        "cmake"
        "curl"
        "gettext"
        "ninja"
    )

    brew update && brew upgrade -y
    for (( i = 1; i <= $#brew_apps; i++)) do
        brew install "$brew_apps[i]"
    done
    for (( i = 1; i <= $#neovim_build_prerequisites; i++)) do
        brew install "$neovim_build_prerequisites[i]"
    done
    for (( i = 1; i <= $#pyenv_build_dependencies; i++)) do
        brew install "$pyenv_build_dependencies[i]"
    done
}


function install_rust () {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}


function install_neovim () {
    cd ~/src/neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
}


function mac_fresh_install () {
    # install_homebrew
    # install_xcode_command_line_tools
    # install_oh_my_zsh

    homebrew_installations

    # install_neovim
    # install_rust

    # yabai --start-service
    # skhd --start-service
}
 
mac_fresh_install 
