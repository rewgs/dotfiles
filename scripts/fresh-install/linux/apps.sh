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

        # Due to zsh not having nested arrays, the simplest way to keep ppas 
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
        apt-get update -qq
	    if [ $? -eq 0 ]; then # `$?` is used to find the return value of the last executed command
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

        for p in "${third_party_ppas}"; do
            add-apt-repository ppa:"$p"
        done

        apt update

        for a in "${ppa_apps}"; do
            apt-get install -y "$a"
        done

    elif [[ $(get_distro) == *"Arch"* ]] ; then
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
            "paru" # Pacman helper
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


        typeset -a aur_apps
        aur_apps=(
            "xrdp"
        )

        echo "Checking for updates..."
        pacman -Syq
	    if [ $? -eq 0 ]; then # `$?` is used to find the return value of the last executed command
	    	echo "Upgrading packages..."
            pacman -Syuq --noconfirm
	    fi

        echo "Installing packages via Pacman..."
        for a in "${apps[@]}"; do
            pacman -Syuq --noconfirm "$a"
        done

        echo "Installing packages via the AUR..."
        for a in "${aur_apps[@]}"; do
            paru -Syuq --noconfirm "$a"
        done
    fi

    echo "Package manager basic installations complete! Moving on..."
    sleep 2

    local result="success"
    echo "$result"
}
