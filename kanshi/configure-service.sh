#!/bin/bash
#
# NOTE: This is not being used. `exec-once` via hyprland works fine now.
# However, I'm keeping this around just in case I ever need to refer to it again.
#
# Using kanshi with hyprland via `exec-once = kanshi` does not work as expected -- 
# I can't hot-reload display configs (i.e. disable the laptop display when plugging 
# into my external, and vice-versa), which is kind of the whole point.
#
# Running it as a service seems to fix this.
#
# Source:
# https://www.reddit.com/r/hyprland/comments/18ukvln/auto_enabledisable_laptop_screen/ldv2yuj/


configure-service::setup() {
    local KANSHI_DOTFILES_DIR="$(realpath $(dirname $BASH_SOURCE))"
    local DOTFILES_DIR="$(realpath $(dirname $KANSHI_DOTFILES_DIR))"
    local SRC="$DOTFILES_DIR/systemd"
    local DST="$HOME/.config/systemd"

    if [[ ! -L "$DST" ]]; then
        ln -s "$SRC" "$DST"
    fi
}


configure-service::run() {
    systemctl --user daemon-reload
    systemctl --user enable kanshi.service
    systemctl --user start kanshi.service
}


configure-service::main() {
    configure-service::setup
    configure-service::run
}
configure-service::main
