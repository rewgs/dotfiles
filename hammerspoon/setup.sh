#!/bin/bash
#
# Sets up hammerspoon dotfiles.


main() {
    symlink_dots() {
        local SRC="$1/dots"
        local DST="$HOME/.hammerspoon"

        if [[ ! -d "$SRC" ]]; then exit 1; fi

        if [[ -L "$DST" ]]; then rm -f "$DST"; fi
        if [[ -d "$DST" ]]; then rm -rf "$DST"; fi

        if [[ ! -L "$DST" ]]; then ln -s "$SRC" "$DST"; fi
    }

    install_spoon() {
        local SPOONS_REPO="$1/dots/Spoons"
        local SPOONS_DIR="$SPOONS_REPO/Spoons"
        
        local SPOON="$2.spoon"

        local SRC="$SPOONS_DIR/$SPOON.zip"
        local DST="$SPOONS_REPO/$SPOON"

        if [[ ! -f "$SRC" ]]; then exit 1; fi
        if [[ -f "$SRC" ]] && [[ ! -d "$DST" ]]; then unzip "$SRC" -d "$SPOONS_REPO"; fi
    }


    local THIS_DIR=$(realpath $(dirname "$BASH_SOURCE"))
    local SPOONS=(
        "WindowHalfsAndThirds"
    )

    symlink_dots "$THIS_DIR"

    for spoon in "${SPOONS[@]}"; do
        install_spoon "$THIS_DIR" "$spoon"
    done

    exit 0
}
main
