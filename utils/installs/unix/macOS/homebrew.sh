#!/bin/bash
#
# Installs packages via Homebrew package manager.


homebrew::mainline-packages() {
    packages=(
        "bettercap"
        "bpytop"
        "broot"
        "btop"
        "chromium --no-quarantine"
        "cmatrix"
        "coreutils" # required for gnu ls (i.e. `gls`, which my `ls_improved()` function uses)
        "cowsay"
        "fnm" # Fast alternative to nvm
        "gh"
        "git"
        "glances"
        "gnu-sed"
        "go"
        "htop"
        "jesseduffield/lazygit/lazygit"
        "mas" # https://github.com/mas-cli/mas
        "--HEAD mosh" # need to install from HEAD for now in order to get true color support; see here: https://github.com/mobile-shell/mosh/issues/945
        "neofetch"
        "netcat"
        # "orbstack"
        "ripgrep"
        "shellcheck"
        # "brew install koekeishiya/formulae/skhd"
        "thefuck"
        "tldr"
        # "koekeishiya/formulae/yabai"
    )

    brew update && brew upgrade

    for p in "${packages[@]}"; do
        brew install "$p"
    done
}


homebrew::casks() {
    packages=(
        # "amethyst"
        "barrier"
        "blackhole-2ch"
        "blackhole-16ch"
        # "dozer" # FOSS menu bar organizer a la Bartender: https://github.com/Mortennn/Dozer
        "eloston-chromium --no-quarantine" # de-Googled Chromium
        "firefox"
        "font-fira-code-nerd-font"
        "google-chrome"
        "hammerspoon"
        # "hyperkey"
        "karabiner-elements"
        "keyboard-maestro"
        "obs"
        # "reaper"
        "rectangle"
    )

    brew update && brew upgrade

    for p in "${packages[@]}"; do
        brew install --cask "$p"
    done
}


homebrew::taps() {
    # Due to zsh not having nested arrays, the simplest way to keep tap and 
    # package installation commands together is to simply list them in order; 
    # therefore, always list the tap before the installation.
    packages=(
        # bun
        "tap oven-sh/bun"
        "install bun"

        # fvm (Flutter Version Manager)
        "tap leoafarias/fvm"
        "install fvm"

        # next app (place-holder)
        # tap dev/app
        # install app
    )

    brew update && brew upgrade

    for p in "${packages[@]}"; do
        brew "$p"
    done
}
