#!/bin/bash

# FIXME: update to work with new folder structure
update_packages () {
    package_manager="$1"
    echo "Checking for updates..."

    if [[ "$package_manager" == "apt" ]]; then
        if [[ $(apt-get update -qq) -eq 0 ]]; then
	    	echo "Upgrading packages..."
            # note: NEEDRESTART_SUSPEND=1 is required in Ubuntu 22.04 LTS in order to prevent a 
            # prompt which asks the user which service(s) should be restarted, if any.
	    	# NEEDRESTART_SUSPEND=1 apt-get upgrade -qq -y
	    	sudo apt-get upgrade -qq -y
	    fi
    elif [[ "$package_manager" == "pacman" ]]; then
        if [[ $(pacman -Syq) -eq 0 ]]; then
	    	echo "Upgrading packages..."
            # the `--needed` flag maybe makes this conditional unnecessary?
            sudo pacman -Syuq --needed --noconfirm
	    fi
    else
        echo "Package manager $package_manager is not supported!"
    fi
}
