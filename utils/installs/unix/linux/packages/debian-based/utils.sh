#!/bin/bash


prevent_prompts () {
    if [[ -f /etc/needrestart/needrestart.conf ]]; then
        # Prevents prompts for restarting services
        sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf

        # Prevents prompts for restarting due to kernel updates
        sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf
    fi
}


remove_snap () {
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
        systemctl disable snapd.service
        systemctl disable snapd.socket
        systemctl disable snapd.seeded.service

        # In an effort to keep this POSIX compliant, arrays are avoided. Instead, 
        #   utilizes `tr` to simulate.
        # `tr ' ' '\n'` performs replaces spaces with new-lines, which are the 
        #   default delimiter for `read`.
        echo "$snap_list" | tr ' ' '\n' | while read item; do
            # As mentioned above, the first item `Name` is skipped.
            if "$item" != "Name"; then
                # can this take a -y flag?
                snap remove "$item"
            fi
        done

        rm -rf /var/cache/snapd

        # this -y flag might be positioned incorrectly
        apt autoremove --purge -y snapd

        rm -rf ~/snap
    # fi
}


install_firefox_without_snap () {
    # assumes that snap has already been removed and `snap remove firefox` run

    # depends on software-properties-common package (installed in `install_from_package_manager()`
    add-apt-repository ppa:mozillateam/ppa

    # alters the Firefox package priority to ensure the PPA/deb/apt version is preferred
    echo '
    Package: *
    Pin: release o=LP-PPA-mozillateam
    Pin-Priority: 1001
    ' | tee /etc/apt/preferences.d/mozilla-firefox

    # ensures future Firefox upgrades are installed
    echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

    apt update && apt install firefox
}
