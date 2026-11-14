#!/bin/bash
#
# Installs packages via MacPorts package manager.

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
    )

    sudo port selfupdate

    for p in "${packages[@]}"; do
        # NOTE: The -N flag is for non-interactive mode, i.e. confirmation checks will be skipped.

        if ! port -q installed "$p" | grep -q "(active)"; then
            echo "Installing $p..."
            sudo port -N install "$p"
        else
            echo "$p is already installed; skipping."
        fi
    done
}
main
