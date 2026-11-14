#!/bin/bash
#
# Installs packages via MacPorts package manager.


function {
}


# function casks {
#     packages=(
#         # "amethyst"
#         "barrier"
#         "blackhole-2ch"
#         "blackhole-16ch"
#         # "dozer" # FOSS menu bar organizer a la Bartender: https://github.com/Mortennn/Dozer
#         "eloston-chromium --no-quarantine" # de-Googled Chromium
#         "firefox"
#         "font-fira-code-nerd-font"
#         "google-chrome"
#         "hammerspoon"
#         # "hyperkey"
#         "karabiner-elements"
#         "keyboard-maestro"
#         "obs"
#         # "reaper"
#         "rectangle"
#     )
#
#     brew update && brew upgrade
#
#     for p in "${packages[@]}"; do
#         brew install --cask "$p"
#     done
# }

function main {
    local packages=(
        "bettercap"
        "blackhole-2ch"
        "blackhole-16ch"
        "bpytop"
        "broot"
        "btop"
        "cmatrix"
        "coreutils" # required for gnu ls (i.e. `gls`, which my `ls_improved()` function uses)
        "cowsay"
        "firefox"
        "fzf"
        "gh"
        "git"
        "glances"
        "gnu-sed"
        "go"
        "google-chrome"
        "hammerspoon"
        "htop"
        "jesseduffield/lazygit/lazygit"
        "karabiner-elements"
        "keyboard-maestro"
        "mas" # https://github.com/mas-cli/mas
        "neofetch"
        "netcat"
        "reaper"
        "rectangle"
        "ripgrep"
        "shellcheck"
        "thefuck"
        "tldr"
    )

    sudo port selfupdate

    for p in "${packages[@]}"; do
        # NOTE: The -N flag is for non-interactive mode, i.e. confirmation checks will be skipped.
        sudo port -N install "$p"
    done
}
main
