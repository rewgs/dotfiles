#!/bin/bash
#
# Symlinks sway dotfiles as necessary to `~/.config/sway`.
# Each directory is the hostname of a machine; a machine with that hostname uses those files.


main() {
    local _THIS_DIR="$(realpath $(dirname "$BASH_SOURCE"))"
    local SRC="$_THIS_DIR/dots"
    local DST="$HOME/.config/sway"
    local DST_DIR="$(realpath $(dirname "$DST"))"

    if [[ ! -d "$DST_DIR" ]]; then mkdir -p "$DST_DIR"; fi

    # The final ~/.config/sway needs to be a symlink. 
    # A directory might already exist in its place. If so, delete it.
    # This will also delete it if it's a symlink (pointing to a directory, which it is).
    if [[ -d "$DST" ]]; then rm -rf "$DST"; fi

    if [[ ! -L "$DST" ]]; then ln -s "$SRC" "$DST"; fi
}
main
