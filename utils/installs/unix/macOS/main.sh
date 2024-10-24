#!/usr/bin/env zsh


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


function install_xcode_command_line_tools () {
    xcode-select --install
}


function install_from_app_store () {
    typeset -a apps
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


function homebrew_installations () {
    typeset -a brew_packages
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

    typeset -a brew_casks
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
    typeset -a brew_taps
    brew_taps=(
        # bun
        "tap oven-sh/bun"
        "install bun"

        # next app (place-holder)
        # tap dev/app
        # install app
    )

    typeset -a neovim_build_prerequisites
    neovim_build_prerequisites=(
        "cmake"
        "curl"
        "gettext"
        "ninja"
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

    typeset -a tmux_build_dependencies
    tmux_build_dependencies=(
        "automake"
        "bison"
        "byacc"
        "libevent"
        "pkg-config"
        "utf8proc"
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
    for (( i = 1; i <= $#neovim_build_prerequisites; i++ )) do
        brew install "$neovim_build_prerequisites[i]"
    done
    for (( i = 1; i <= $#pyenv_build_dependencies; i++ )) do
        brew install "$pyenv_build_dependencies[i]"
    done
    for (( i = 1; i <= $#tmux_build_dependencies; i++ )) do
        brew install "$tmux_build_dependencies[i]"
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


function install_tmux () {
    cd ~/src/tmux
    sh autogen.sh
    .configure --enable-utf8proc
    make
    sudo make install
}


function clone_repositories () {
    # library for helping one work with 
    typeset -A hyperkey_spoon
    hyperkey_spoon=(
        [name]="HyperKey.spoon"
        [url]="git@github.com:dbalatero/HyperKey.spoon.git"
        [src]="~/src/$hyperkey_spoon[name]/"
        [dst]="~/.hammerspoon/Spoons/$hyperkey_spoon[name]"
        [symlink]="ln -s $hyperkey_spoon[src] $hyperkey_spoon[dst]"
    )

    typeset -a repos
    repos=(
        $hyperkey_spoon
    )

    cd ~/src
    for (( i = 1; i <= $#repos; i++ )) do
        repo=$repos[i]
        git clone $repo[url] $repo[src]

        if [ $repo[symlink] ]; then
            $repo[symlink]
        fi
    done
}


function mac_fresh_install () {
    current=$(pwd)
    log_file="$current/installation_log.txt"

    cd "$current" || return

    # install_homebrew
    # install_xcode_command_line_tools
    # install_oh_my_zsh

    homebrew_installations

    # neovim
    cd "$current" || return
    source ./neovim.sh
    install_neovim_build_prerequisites
    build_neovim_from_source
    install_packer_nvim
    echo "neovim installation finished!" | cat >> "$log_file"

    # install_rust

    # yabai --start-service
    # skhd --start-service
}
 
mac_fresh_install 
