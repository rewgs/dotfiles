#!/bin/bash

# ssh keys
# github
#
# - Notes on Tailscale:
#   - The App Store version *will not work!* `ssh` is not allowed with it, so do not install it.
#   - install golang
#   - `go install tailscale.com/cmd/tailscale{,d}@main` 
#   - Add ~/go/bin to PATH: place `export PATH=$PATH:$(go env GOPATH)/bin` in .zshrc
#   - Run `sudo tailscaled install-system-daemon` so that `tailscaled` runs in the background at startup
#   - Authenticate as usual with `tailscale up` and `tailscale up --ssh`


install_xcode_command_line_tools() {
    xcode-select --install
}


install_from_app_store() {
    apps=(
        "Adblock Plus"
        "BetterSnapTool"
        "Bitwarden"
        "Developer"
        "Keynote"
        "LanScan"
        "Logic Pro"
        "Microsoft Remote Desktop"
        "Numbers"
        "Pages"
        "Slack"
        "Tailscale"
        "The Unarchiver"
        "UTM"
        "Vimari"
        "WhatsApp"
        "Xcode"
    )
    for (( i = 1; i <= $#apps; i++)) do
        app_id=$(mas search "$apps[i]")
        mas install "$app_id"
    done
}


homebrew_installations() {
    brew_packages=(
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

    brew_casks=(
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

    # Due to zsh not having nested arrays, the simplest way to keep tap and 
    # package installation commands together is to simply list them in order; 
    # therefore, always list the tap before the installation.
    brew_taps=(
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
    for (( i = 1; i <= $#brew_packages; i++)) do
        brew install "$brew_packages[i]"
    done
    for (( i = 1; i <= $#brew_casks; i++ )) do
        brew install --cask "$brew_casks[i]"
    done
    for (( i = 1; i <= $#brew_taps; i++ ))do
        brew "$brew_taps[i]"
    done
}
