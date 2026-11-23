#!/bin/bash
#
# Installs packages via MacPorts package manager.

function main {
    local packages=(
        "bettercap"
        "bpytop"
        "broot"
        "btop"
        "cmatrix"
        "coreutils" # required for gnu ls (i.e. `gls`, which my `ls_improved()` function uses)
        "cowsay"
        # "firefox" # FIXME: package not found
        "fzf"
        "gh"
        "git"
        "glances"
        # "gnu-sed" # FIXME: package not found
        "go"
        # "google-chrome" # FIXME: package not found
        # "hammerspoon" # FIXME: package not found
        "htop"
        # "jesseduffield/lazygit/lazygit" # FIXME: package not found
        # "karabiner-elements" # FIXME: package not found
        # "keyboard-maestro" # FIXME: package not found
        "mas" # https://github.com/mas-cli/mas # NOTE: Requires a full Xcode installation prior to installing.
        "neofetch"
        # "netcat" # FIXME: package not found
        # "reaper" # FIXME: package not found
        # "rectangle" # FIXME: package not found
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
