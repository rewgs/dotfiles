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
    typeset -a brew_apps
    brew_apps=(
        "bettercap"
        "bpytop"
        "btop"
        "cmatrix"
        "coreutils"
        "cowsay"
        "gh"
        "git"
        "glances"
        "gnu-sed"
        "htop"
        "jesseduffield/lazygit/lazygit"
        "mas" # https://github.com/mas-cli/mas
        "neofetch"
        "shellcheck"
        "brew install koekeishiya/formulae/skhd"
        "thefuck"
        "tldr"
        "koekeishiya/formulae/yabai"
    )

    typeset -a brew_casks
    brew_casks=(
        "amethyst"
        "blackhole-2ch"
        "blackhole-16ch"
        "firefox"
        "font-fira-code-nerd-font"
        "google-chrome"
        "hammerspoon"
        "hyperkey"
        "karabiner-elements"
        "obs"
        "reaper"
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
    for (( i = 1; i <= $#brew_apps; i++)) do
        brew install "$brew_apps[i]"
    done
    for (( i = 1; i <= $#brew_casks; i++ )) do
        brew install --cask "$brew_casks[i]"
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
    }

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