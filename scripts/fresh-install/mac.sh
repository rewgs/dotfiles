#!/usr/bin/env zsh


# ssh keys
# github


install_homebrew { 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}


install_oh_my_zsh {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


install_xcode_command_line_tools {
    xcode-select --install
}


homebrew_installations {
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

    brew update && brew upgrade -y

    for (( = 1; i <= $#array; i++)) do
        brew install $brew_apps[i]
    done
}


install_rust {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}


mac_fresh_install {
    install_homebrew
    install_xcode_command_line_tools
    install_oh_my_zsh

    yabai --start-service
    skhd --start-service
}
 
mac_fresh_install 
