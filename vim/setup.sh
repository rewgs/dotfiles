#!/bin/bash


setup () {
    # gets the absolute file of this script's parent dir
    local SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    # echo "$SCRIPTPATH"

    local src="$SCRIPTPATH/vimrc"
    local dst="$HOME/.vimrc"

    ln -s "$src" "$dst"
}
setup
