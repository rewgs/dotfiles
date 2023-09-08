#!/usr/bin/env bash

function install_apps_from_package_manager () {
    typeset -a apps 
    apps=(
        "apache2"
        "apt-file" # this is SO useful. `apt-file search "header.h"` will help find the -dev package that contains it.
        "apt-transport-https"
        "automake"
        "bettercap"
        "bpytop"
        "btop"
        "build-essential"
        "cbonsai"
        "cmake"
        "cmatrix"
        "cowsay"
        "curl"
        "docker"
        "docker-compose"
        "git"
        "glances"
        "gnupg2"
        "golang-go"
        "hsetroot"
        "htop"
        "libvirt-daemon"
        "llvm"
        "lua5.4"
        "lynx"
        "make"
        "ncat"
        "ncdu"
        "neofetch"
        "nmap"
        "picom"
        "qemu-kvm"
        "shellcheck"
        "software-properties-common"
        "tgt"
        "thefuck"
        "tldr"
        "tree"
        "unzip"
        "vim"
        "wget"
        "xorg"
        "zip"
        "zsh"
    )

    if [[ $(get_distro) == *"Debian"* ]] || [[ $(get_distro) == *"Ubuntu"* ]] ; then
        echo "Checking for updates..."

        sudo apt-get update -qq
	    if [ $? -eq 0 ]; then # `$?` is used to find the return value of the last executed command
	    	echo "Upgrading packages..."
	    	sudo apt-get upgrade -qq -y
	    fi

        echo "Installing packages from package manager..."
        for a in "${apps[@]}"; do
            sudo apt-get install -y "$a"
	        # > /dev/null 2> /dev/null # for some reason, `&> /dev/null` isn't silent, but this is
        done
    elif [[ $(get_distro) == *"Arch"* ]] ; then
        echo "Checking for updates..."
        sudo pacman -Syq
	    if [ $? -eq 0 ]; then # `$?` is used to find the return value of the last executed command
	    	echo "Upgrading packages..."
            sudo pacman -Syuq --noconfirm
	    fi

        # echo "Installing packages from package manager..."
        # for a in "${apps[@]}"; do
            # sudo pacman -Syuq --noconfirm "$a"
        # done
    fi

    echo "Package manager basic installations complete! Moving on..."
    sleep 2
}


function make_dotfiles_symlinks () {
    # bash
    typeset -a bash_dots
    bash_dots=(
        "bashrc"
        "bash_profile"
    )
    for d in "${bash_dots[@]}"; do
        if [ -f "$HOME/.$d" ] || [ -h "$HOME/.$d" ]; then
            rm "$HOME/.$d"
        fi
        ln -s "$HOME/dotfiles/bash/$d" "$HOME/.$d"
    done

    # nvim
    if [ ! -d "$HOME/.config" ]; then
        mkdir "$HOME/.config"
    fi
    if [ -d "$HOME/.config/nvim" ] || [ -h "$HOME/.config/nvim" ]; then
        rm "$HOME/.config/nvim"
    fi
    ln -s "$HOME/dotfiles/nvim/" "$HOME/.config/nvim"

    # sh
    if [ -f "$HOME/.profile" ] || [ -h "$HOME/.profile" ]; then
        rm "$HOME/.profile"
    fi
    ln -s "$HOME/dotfiles/sh/profile" "$HOME/.profile"

    # tmux
    if [ -f "$HOME/.tmux.conf" ] || [ -h "$HOME/.tmux.conf" ]; then
        rm "$HOME/.tmux.conf"
    fi
    ln -s "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
     
    # tpm
    if [ -h "$HOME"/.tmux/plugins/tpm ]; then
        rm "$HOME"/.tmux/plugins/tpm
    fi
    ln -s "$HOME/src/tpm/" "$HOME/.tmux/plugins/tpm"
    
    # zsh
    typeset -a zsh_dots
    zsh_dots=(
        "zlogin"
        "zlogout"
        "zprofile"
        "zshenv"
        "zshrc"
    )
    for z in "${zsh_dots[@]}"; do
        if [ -f "$HOME/.$z" ] || [ -h "$HOME/.$z" ]; then
            rm "$HOME/.$z"
        fi
        ln -s "$HOME/dotfiles/zsh/$z" "$HOME/.$z"
    done

    echo "Symlinking dotfiles complete!"
}


function main () {
    source ./utils.sh
    # This isn't really working. Commenting out for now.
    # remove_snap
    
    install_apps_from_package_manager

    source ./misc_installs.sh
    install_github_cli
    
    # tmux
    source ./tmux.sh
    install_tmux_from_source
    install_tmux_package_manager

    # for some reason, the following isn't running:
    # - neovim
    # - nodejs
    # - phpenv
    # - pyenv
    # ...but then install_oh_my_zsh runs. wtf?
    
    # neovim
    source ./neovim.sh
    install_neovim_dependencies
    build_neovim_from_source
    install_packer_nvim
    
    # nodejs
    source ./nodejs.sh
    install_nvm_from_source
    prep_for_nvm_nodejs_installs
    install_nodejs
    
    # phpenv
    source ./phpenv.sh
    install_phpenv_build_prerequisites
    install_phpenv_from_source
    
    # pyenv
    source ./pyenv.sh
    install_pyenv_build_dependencies
    install_pyenv_from_source
    prep_for_pyenv_python_installs
    install_python
    
    install_oh_my_zsh
    sudo chsh -s "$(which zsh)" "$(whoami)"
    make_dotfiles_symlinks
    
    echo "All done! Restarting now..."
    sudo reboot
    
    source ./rust.sh
    install_rust

    install_cargo_apps
    install_npm_apps

    source ./gui.sh
    install_fira_code_nerd_font
}
main
