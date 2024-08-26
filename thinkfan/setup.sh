#!/bin/bash
#
# Symlinks thinkfan config file.

setup::main() {
    local SRC="$(realpath $(dirname $BASH_SOURCE))/thinkfan.yaml"
    local DST="/etc/thinkfan.yaml"

    if [[ ! -d "$(dirname $DST)" ]]; then 
        mkdir "$(dirname $DST)"
    fi

    if [[ -d "$DST" ]] || [[ -L "$DST" ]]; then
        sudo rm -rf "$DST"
    fi

    if [[ ! -L "$DST" ]]; then
        sudo ln -s "$SRC" "$DST"
    fi
}
setup::main
