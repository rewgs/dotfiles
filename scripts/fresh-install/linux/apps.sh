#!/usr/bin/env bash


# This replaces the need for `NEEDRESTART_SUSPEND=1` prior to `apt get install "$a"`
# Couldn't get anything to actually work
# function uninstall_apps_with_package_manager () {
#     if [[ $(get_distro) == *"Debian"* ]] || [[ $(get_distro) == *"Ubuntu"* ]] ; then
#         typset -a apps
#         apps=(
#             "needrestart"
#         )

#         for a in "${apps[@]}"; do
#             apt-get remove "$a"
#         done
#     fi
# }


function install_apps_from_package_manager () {
    if [[ $(get_distro) == *"Debian"* ]] || [[ $(get_distro) == *"Ubuntu"* ]] ; then
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
            "wl-clipboard" # dead simple clipboard utility for Wayland-based window managers; https://github.com/bugaevc/wl-clipboard
            "wget"
            "xorg"
            "zip"
            "zsh"
        )

        # Due to bash not having nested arrays, the simplest way to keep ppas 
        # and packages commands is to put them in separate arrays, add the ppas, 
        # then install the apps.
        typeset -a third_party_ppas
        third_party_ppas=(
            "nschloe/waybar" # status bar for swaywm; uses X11 though, not Wayland
        )

        typeset -a ppa_apps
        ppa_apps=(
            "waybar"
        )


        prevent_prompts

        echo "Checking for updates..."
        if [[ $(apt-get update -qq) -eq 0 ]]; then
	    	echo "Upgrading packages..."
            # note: NEEDRESTART_SUSPEND=1 is required in Ubuntu 22.04 LTS in order to prevent a 
            # prompt which asks the user which service(s) should be restarted, if any.
	    	# NEEDRESTART_SUSPEND=1 apt-get upgrade -qq -y
	    	apt-get upgrade -qq -y
	    fi

        echo "Installing packages via apt..."
        for a in "${apps[@]}"; do
            # note: NEEDRESTART_SUSPEND=1 is required in Ubuntu 22.04 LTS in order to prevent a 
            # prompt which asks the user which service(s) should be restarted, if any.
            # NEEDRESTART_SUSPEND=1 apt-get install -y "$a"
            apt-get install -y "$a"
	        # > /dev/null 2> /dev/null # for some reason, `&> /dev/null` isn't silent, but this is
        done

        for p in "${third_party_ppas[@]}"; do
            add-apt-repository ppa:"$p"
        done

        apt update

        for a in "${ppa_apps[@]}"; do
            apt-get install -y "$a"
        done

    elif [[ $(get_distro) == *"Arch"* ]] ; then
        typeset -a apps 
        apps=(
            # NOTE: commented-out packages are incorrect package names (as these were copied from 
            # apt script above); need to find correct package name for Pacman
            "apache"
            "arp-scan"
            "automake"
            "base-devel" # equivalent to apt's built-essential
            "bettercap"
            "bpytop"
            "btop"
            "cmake"
            "cmatrix"
            "cowsay"
            "curl"
            "docker"
            "docker-compose"
            "git"
            "glances"
            "gnu-ncat"
            "gnupg"
            "go"
            "hsetroot"
            "htop"
            "libvirt"
            "llvm"
            "lua"
            "lynx"
            "make"
            "ncdu"
            "neofetch"
            "net-tools"
            "nmap"
            # "paru" # Pacman helper; can't install this with Pacman, need to install manually: https://github.com/Morganamilo/paru
            "picom"
            "qemu-full"
            # "shellcheck" # not available for ARM?
            "software-properties-common"
            # "tgt"
            "thefuck"
            "tldr"
            "tree"
            "unzip"
            "vim"
            "wl-clipboard" # dead simple clipboard utility for Wayland-based window managers; https://github.com/bugaevc/wl-clipboard
            "wget"
            "xorg"
            "zip"
            "zsh"
        )


        typeset -a aur_apps
        aur_apps=(
            "cbonsai"
            "xrdp"
        )

        echo "Checking for updates..."
        if [ $(pacman -Syq) -eq 0 ]; then
	    	echo "Upgrading packages..."
            # the `--needed` flag maybe makes this conditional unnecessary?
            pacman -Syuq --needed --noconfirm
	    fi

        echo "Installing packages via Pacman..."
        for a in "${apps[@]}"; do
            # `pacman -Q` queries the installed local package database; `-i` returns information on the package.
            # If exit code is 0, package is installed; otherwise, it's not.
            if [[ ! $(pacman -Qi "$a") ]]; then
                pacman -Syuq --noconfirm "$a"
            fi
        done

        # echo "Installing packages via the AUR..."
        # for a in "${aur_apps[@]}"; do
        #     paru -Syuq --noconfirm "$a"
        # done
    fi

    echo "Package manager basic installations complete! Moving on..."
    sleep 2

    local result="success"
    echo "$result"
}
