#!/usr/bin/env zsh


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ functions                                                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝



# TODO: make sure this works on macOS!
function make_dotfiles_symlinks () {
    # ╔════════════════════════════════════════════════════════════════════════════╗
    # ║ make directories                                                           ║
    # ╚════════════════════════════════════════════════════════════════════════════╝
    
    if [ ! -d "$HOME"/.config ]; then
        mkdir "$HOME"/.config
    fi
    
    if [ ! -d "$HOME"/dotfile_backups/bash ]; then
        mkdir -p "$HOME"/dotfile_backups/bash
    fi
    
    if [ ! -d "$HOME"/dotfile_backups/nvim ]; then
        mkdir -p "$HOME"/dotfile_backups/nvim
    fi
    
    if [ ! -d "$HOME"/dotfile_backups/sh ]; then
        mkdir -p "$HOME"/dotfile_backups/sh
    fi
    
    if [ ! -d "$HOME"/dotfile_backups/tmux ]; then
        mkdir -p "$HOME"/dotfile_backups/tmux
    fi
    
    if [ ! -d "$HOME"/dotfile_backups/zsh ]; then
        mkdir -p "$HOME"/dotfile_backups/zsh
    fi
    
    # ╔════════════════════════════════════════════════════════════════════════════╗
    # ║ create symlinks (and backup if target already present)                     ║
    # ╚════════════════════════════════════════════════════════════════════════════╝
    
    # bash
    if [ -f "$HOME"/.bashrc ]; then
        mv "$HOME"/.bashrc "$HOME"/dotfile_backups/bashrc
        ln -s "$HOME"/dotfiles/bash/bashrc "$HOME"/.bashrc
    elif [ -h "$HOME"/.bashrc ]; then
        rm "$HOME"/.bashrc
        ln -s "$HOME"/dotfiles/bash/bashrc "$HOME"/.bashrc
    else
        ln -s "$HOME"/dotfiles/bash/bashrc "$HOME"/.bashrc
    fi
    
    if [ -f "$HOME"/.bash_profile ]; then
        mv "$HOME"/.bash_profile "$HOME"/dotfile_backups/bash_profile
        ln -s "$HOME"/dotfiles/bash/bash_profile "$HOME"/.bash_profile
    elif [ -h "$HOME"/.bash_profile ]; then
        rm "$HOME"/.bash_profile
        ln -s "$HOME"/dotfiles/bash/bash_profile "$HOME"/.bash_profile
    else
        ln -s "$HOME"/dotfiles/bash/bash_profile "$HOME"/.bash_profile
    fi
    

    # nvim
    if [ -d "$HOME"/.config/nvim ]; then
        mv "$HOME"/.config/nvim "$HOME"/dotfile_backups/nvim
        ln -s "$HOME"/dotfiles/nvim/ "$HOME"/.config/nvim
    elif [ -h "$HOME"/.config/nvim ]; then
        rm "$HOME"/.config/nvim/
        ln -s "$HOME"/dotfiles/nvim/ "$HOME"/.config/nvim
    else
        ln -s "$HOME"/dotfiles/nvim/ "$HOME"/.config/nvim
    fi
    

    # sh
    if [ -f "$HOME"/.profile ]; then
        mv "$HOME"/.profile "$HOME"/dotfile_backups/sh/
        ln -s "$HOME"/dotfiles/sh/profile "$HOME"/.profile
    elif [ -h "$HOME"/.profile ]; then
        rm "$HOME"/.profile
        ln -s "$HOME"/dotfiles/sh/profile "$HOME"/.profile
    else
        ln -s "$HOME"/dotfiles/sh/profile "$HOME"/.profile
    fi
    
    # tmux
    if [ -f "$HOME"/.tmux.conf ]; then
        mv "$HOME"/.tmux.conf "$HOME"/dotfile_backups/tmux/
        ln -s "$HOME"/dotfiles/tmux/tmux.conf "$HOME"/.tmux.conf
    elif [ -h "$HOME"/.tmux.conf ]; then
        rm "$HOME"/.tmux.conf
        ln -s "$HOME"/dotfiles/tmux/tmux.conf "$HOME"/.tmux.conf
    else
        ln -s "$HOME"/dotfiles/tmux/tmux.conf "$HOME"/.tmux.conf
    fi
     
    if [ ! -d "$HOME"/src/tpm ]; then
        ln -s "$HOME"/src/tpm/ "$HOME"/.tmux/plugins/tpm
    elif [ -h "$HOME"/.tmux/plugins/tpm ]; then
        rm "$HOME"/.tmux/plugins/tpm
        ln -s "$HOME"/src/tpm/ "$HOME"/.tmux/plugins/tpm
    else
        ln -s "$HOME"/src/tpm/ "$HOME"/.tmux/plugins/tpm
    fi
    
    # zsh
    if [ -f "$HOME"/.zshenv ]; then
        mv "$HOME"/.zshenv "$HOME"/dotfile_backups/zsh/
        ln -s "$HOME"/dotfiles/zsh/zshenv "$HOME"/.zshenv
    elif [ -h "$HOME"/.zshenv ]; then
        rm "$HOME"/.zshenv
        ln -s "$HOME"/dotfiles/zsh/zshenv "$HOME"/.zshenv
    else
        ln -s "$HOME"/dotfiles/zsh/zshenv "$HOME"/.zshenv
    fi
    
    if [ -f "$HOME"/.zprofile ]; then
        mv "$HOME"/.zprofile "$HOME"/dotfile_backups/zsh/
        ln -s "$HOME"/dotfiles/zsh/zprofile "$HOME"/.zprofile
    elif [ -h "$HOME"/.zprofile ]; then
        rm "$HOME"/.zprofile
        ln -s "$HOME"/dotfiles/zsh/zprofile "$HOME"/.zprofile
    else
        ln -s "$HOME"/dotfiles/zsh/zprofile "$HOME"/.zprofile
    fi
    
    if [ -f "$HOME"/.zshrc ]; then
        mv "$HOME"/.zshrc "$HOME"/dotfile_backups/zsh/
        ln -s "$HOME"/dotfiles/zsh/zshrc "$HOME"/.zshrc
    elif [ -h "$HOME"/.zshrc ]; then
        rm "$HOME"/.zshrc
        ln -s "$HOME"/dotfiles/zsh/zshrc "$HOME"/.zshrc
    else
        ln -s "$HOME"/dotfiles/zsh/zshrc "$HOME"/.zshrc
    fi
    
    if [ -f "$HOME"/.zlogin ]; then
        mv "$HOME"/.zlogin "$HOME"/dotfile_backups/zsh/
        ln -s "$HOME"/dotfiles/zsh/zlogin "$HOME"/.zlogin
    elif [ -h "$HOME"/.zlogin ]; then
        rm "$HOME"/.zlogin
        ln -s "$HOME"/dotfiles/zsh/zlogin "$HOME"/.zlogin
    else
        ln -s "$HOME"/dotfiles/zsh/zlogin "$HOME"/.zlogin
    fi
    
    if [ -f "$HOME"/.zlogout ]; then
        mv "$HOME"/.zlogout "$HOME"/dotfile_backups/zsh/
        ln -s "$HOME"/dotfiles/zsh/zlogout "$HOME"/.zlogout
    elif [ -h "$HOME"/.zlogout ]; then
        rm "$HOME"/.zlogout
        ln -s "$HOME"/dotfiles/zsh/zlogout "$HOME"/.zlogout
    else
        ln -s "$HOME"/dotfiles/zsh/zlogout "$HOME"/.zlogout
    fi

    echo "Symlinking dotfiles complete!"
}


function install_lazygit_from_source () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/jesseduffield/lazygit.git
    cd "$HOME"/src/lazygit
    go install
}


function install_npm_apps () {
    typeset -a npm_apps
    npm_apps=(
        "gtop -g"
    )

    for (( i = 1; i <= $#npm_apps; i++)) do
        npm install "$npm_apps[i]"
    done
}


function install_rust_apps () {
    typeset -a rust_apps
    rust_apps=(
	    "cargo-audi"
	    "cargo-edit"
	    "cargo-make"
	    "cargo-tarpaulin"
	    "cargo-watch"
        "ytop"
    )

    for (( i = 1; i <= $#rust_apps; i++)) do
        cargo install "$rust_apps[i]"
    done
}





function install_firefox_without_snap () {
    # assumes that snap has already been removed and `sudo snap remove firefox` run

    # depends on software-properties-common package (installed in `install_from_package_manager()`
    sudo add-apt-repository ppa:mozillateam/ppa

    # alters the Firefox package priority to ensure the PPA/deb/apt version is preferred
    echo '
    Package: *
    Pin: release o=LP-PPA-mozillateam
    Pin-Priority: 1001
    ' | sudo tee /etc/apt/preferences.d/mozilla-firefox

    # ensures future Firefox upgrades are installed
    echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

    sudo apt update && sudo apt install firefox
}


function install_fira_code_nerd_font () {
    mkdir ~/.fonts
    cd ~/.fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
    unzip FiraCode.zip
    rm FiraCode.zip
    fc-cache -fv
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ macros                                                                     ║
# ║                                                                            ║
# ║ These are comprised of the individual functions above.                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function personal_setup_cli () {
    # not working now so not running
    # install_lazygit_from_source

    install_npm_apps

    # can't find a way to make cargo seen, so commenting out for now
    # install_rust_apps

    make_dotfiles_symlinks

    echo "All finished!"
    exec $SHELL
}


function personal_setup_gui () {
    install_firefox_without_snap
    install_fira_code_nerd_font
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ main                                                                       ║
# ║                                                                            ║
# ║ Comprised of one or more macros; separated by machine usage.               ║
# ║ These don't overlap at all -- instead they cascade/build upon each other.  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function main() {
    personal_setup_cli
    # personal_setup_gui
}

main
