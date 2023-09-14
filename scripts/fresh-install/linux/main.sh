#!/usr/bin/env bash


function prevent_prompts () {
    # Prevents prompts for restarting services
    sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf

    # Prevents prompts for restarting due to kernel updates
    sudo sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf
}


# This replaces the need for `NEEDRESTART_SUSPEND=1` prior to `apt get install "$a"`
# Couldn't get anything to actually work
function uninstall_apps_with_package_manager () {
    if [[ $(get_distro) == *"Debian"* ]] || [[ $(get_distro) == *"Ubuntu"* ]] ; then
        typset -a apps
        apps=(
            "needrestart"
        )

        for a in "${apps[@]}"; do
            sudo apt-get remove "$a"
        done
    fi
}


function install_apps_from_package_manager () {
    typeset -a apps 
    apps=(
        "apache2"
        "apt-file" # this is SO useful. `apt-file search "header.h"` will help find the -dev package that contains it.
        "apt-transport-https"
        "arp-scan"
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
        "net-tools"
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
        prevent_prompts

        echo "Checking for updates..."
        sudo apt-get update -qq
	    if [ $? -eq 0 ]; then # `$?` is used to find the return value of the last executed command
	    	echo "Upgrading packages..."
            # note: NEEDRESTART_SUSPEND=1 is required in Ubuntu 22.04 LTS in order to prevent a 
            # prompt which asks the user which service(s) should be restarted, if any.
	    	# sudo NEEDRESTART_SUSPEND=1 apt-get upgrade -qq -y
	    	sudo apt-get upgrade -qq -y
	    fi

        echo "Installing packages from package manager..."
        for a in "${apps[@]}"; do
            # note: NEEDRESTART_SUSPEND=1 is required in Ubuntu 22.04 LTS in order to prevent a 
            # prompt which asks the user which service(s) should be restarted, if any.
            # sudo NEEDRESTART_SUSPEND=1 apt-get install -y "$a"
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
    current=$(pwd)
    log_file="$current/installation_log.txt"

    cd "$current" || return
    source ./utils.sh
    # This isn't really working. Commenting out for now.
    # remove_snap

    # cd "$current" || return
    # echo "Running uninstall_apps_with_package_manager()" | cat >> "$log_file"
    # uninstall_apps_with_package_manager
    # echo "uninstall_apps_with_package_manager() finished!" | cat >> "$log_file"
    
    cd "$current" || return
    echo "Running install_apps_from_package_manager()" | cat >> "$log_file"
    install_apps_from_package_manager
    echo "install_apps_from_package_manager() finished!" | cat >> "$log_file"

    cd "$current" || return
    source ./misc_installs.sh
    echo "Running install_github_cli()" | cat >> "$log_file"
    install_github_cli
    echo "install_github_cli() finished!" | cat >> "$log_file"
    
    # tmux
    cd "$current" || return
    source ./tmux.sh
    echo "Installing tmux and tpm" | cat >> "$log_file"
    install_tmux_from_source
    install_tmux_package_manager
    echo "tmux and tpm installation finished!" | cat >> "$log_file"

    # for some reason, the following isn't running:
    # - neovim
    # - nodejs
    # - phpenv
    # - pyenv
    # ...but then install_oh_my_zsh runs. wtf?
    
    # neovim
    cd "$current" || return
    source ./neovim.sh
    echo "Installing neovim" | cat >> "$log_file"
    install_neovim_dependencies
    build_neovim_from_source
    install_packer_nvim
    echo "neovim installation finished!" | cat >> "$log_file"
    
    # nodejs
    cd "$current" || return
    source ./nodejs.sh
    echo "Installing nvm and nodejs" | cat >> "$log_file"
    install_nvm_from_source
    prep_for_nvm_nodejs_installs
    install_nodejs
    echo "nvm and nodejs installation finished!" | cat >> "$log_file"
    
    # phpenv
    cd "$current" || return
    source ./phpenv.sh
    echo "Installing phpenv" | cat >> "$log_file"
    install_phpenv_build_prerequisites
    install_phpenv_from_source
    echo "phpenv installation finished!" | cat >> "$log_file"
    
    # pyenv
    cd "$current" || return
    source ./pyenv.sh
    echo "Installing pyenv" | cat >> "$log_file"
    install_pyenv_build_dependencies
    install_pyenv_from_source
    echo "pyenv installation finished!" | cat >> "$log_file"
    # echo "Installing Python" | cat >> "$log_file"
    prep_for_pyenv_python_installs
    # python isn't being installed for some reason
    # install_python
    # echo "Python installation finished!" | cat >> "$log_file"
    
    echo "Installing ohmyzsh..." | cat >> "$log_file"
    install_oh_my_zsh
    echo "ohmyzsh installation finished!" | cat >> "$log_file"
    echo "Changing shell to zsh..." | cat >> "$log_file"
    sudo chsh -s "$(which zsh)" "$(whoami)"
    echo "Shell should now be zsh!" | cat >> "$log_file"
    echo "Symlinking to dotfiles..." | cat >> "$log_file"
    make_dotfiles_symlinks
    echo "Dotfiles symlinked!" | cat >> "$log_file"
    
    echo "All done! Restarting now..."
    sudo reboot
    
    cd "$current" || return
    source ./rust.sh
    install_rust
    install_cargo_apps

    # not working for some reason
    # install_npm_apps

    cd "$current" || return
    source ./gui.sh
    install_fira_code_nerd_font
}
main
