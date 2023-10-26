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


function prevent_prompts () {
    # Prevents prompts for restarting services
    sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf

    # Prevents prompts for restarting due to kernel updates
    sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" /etc/needrestart/needrestart.conf
}


function get_distro () {
    ( lsb_release -ds || cat /etc/*release || uname -om ) 2>/dev/null | head -n1
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
