if [[ "$(uname)" != "Linux" ]]; then
    exit 1
fi

function start_gnome() {
    if [[ ! "$(systemctl is-active --quiet gdm.service)" ]]; then
        "$(systemctl start gdm.service)"
    fi
}

alias cosmic="start-cosmic"
# alias gnome="gnome-shell --wayland"
alias gnome=start_gnome
alias plasma="/usr/bin/startplasma-wayland"
alias xfce="startxfce4"
