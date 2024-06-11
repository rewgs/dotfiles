#!/bin/bash
#
# Sets up Phoenix.

setup::main() {
    local SRC="$(realpath $(dirname ${BASH_SOURCE}))/dots/phoenix.js"
    local DST="$HOME/.phoenix.js"

    if [[ -f "$DST" ]]; then 
        rm -f "$DST"; 
    fi

    if [[ ! -L "$DST" ]]; then
        ln -s "$SRC" "$DST"
    fi
}
setup::main
