start_gnome() {
    if ! systemctl is-active --quiet gdm.service; then
        systemctl start gdm.service
    fi
}

alias cosmic="start-cosmic"
