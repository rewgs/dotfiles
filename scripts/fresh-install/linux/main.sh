#!/usr/bin/env bash

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ functions                                                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function get_distro () {
    ( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1
}


function install_from_package_manager () {
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

        echo "Installing packages from package manager..."
        for a in "${apps[@]}"; do
            sudo pacman -Syuq --noconfirm "$a"
        done
    fi

    echo "Package manager basic installations complete! Moving on..."
    sleep 3
}


function remove_snap () {
    # FIXME: 
    # - POSIX sh doesn't support globbing. Convert the following line to case statements.
    # - ^ isn't urgent, as right now I'm only running this on apt-based distros.
    #   Will matter more once I adapt this to be distro-agnostic.
    # if [ "$(uname --all)" = *"Ubuntu"* ]; then
        # Returns list of snaps installed.
        # This is a very simple usage of awk, so the first item is `Name`, i.e. the 
        #   name of the first column. It will have to be skipped over when 
        #   iterating over these later.
        snap_list="$(snap list | awk '{print $1}')"

        # stop snap services
        sudo systemctl disable snapd.service
        sudo systemctl disable snapd.socket
        sudo systemctl disable snapd.seeded.service

        # In an effort to keep this POSIX compliant, arrays are avoided. Instead, 
        #   utilizes `tr` to simulate.
        # `tr ' ' '\n'` performs replaces spaces with new-lines, which are the 
        #   default delimiter for `read`.
        echo "$snap_list" | tr ' ' '\n' | while read item; do
            # As mentioned above, the first item `Name` is skipped.
            if "$item" != "Name"; then
                # can this take a -y flag?
                sudo snap remove "$item"
            fi
        done

        sudo rm -rf /var/cache/snapd

        # this -y flag might be positioned incorrectly
        sudo apt autoremove --purge -y snapd

        sudo rm -rf ~/snap
    # fi
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
    # This isn't really working. Commenting out for now.
    # remove_snap
    
    install_from_package_manager

    source ./misc_installs.sh
    install_github_cli
    
    # tmux
    source ./tmux.sh
    install_tmux_from_source
    install_tmux_package_manager
    
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
    sudo chsh -s $(which zsh) $(whoami)
    make_dotfiles_symlinks
    
    # echo "All done! Restarting now..."
    # sudo reboot
    
    source ./rust.sh
    install_rust

    install_cargo_apps
    install_npm_apps

    source ./gui.sh
    install_fira_code_nerd_font
}
main
