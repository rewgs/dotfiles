#!/bin/bash
#
# Sets up neovim on Unix systems.
# Symlinks the `$DOTFILES/nvim/dots/${package_manager}` dir to `~/.config/nvim`.


nvim-setup::exists() {
    local DIR="$1"
    if [[ ! -d "${DIR}" ]]; then
        echo "${DIR} does not exist!"
    # else
    #     echo "${DIR} exists!"
    fi    
}

nvim-setup::main() {
    local PKG_MGR="$1" # lazy or packer
    local DOTS="$(realpath $(dirname ${BASH_SOURCE}))/dots"
    local SRC="$(realpath $DOTS/${PKG_MRG}/${HOSTNAME})"
    local DST="$HOME/.config/nvim"



    #
    # if [[ ! -d "$(dirname $DST)" ]]; 
    #     then mkdir -p "$(dirname $DST)"; 
    # fi
    #
    # if [[ -d "$DST" ]] || [[ -L "$DST" ]]; 
    #     then rm -rf "$DST"; 
    # fi
    #
    # if [[ ! -L "$DST" ]]; then
    #     ln -s "$SRC" "$DST"
    # fi
}

# TODO: Check that the arg is provided; error handling if it isn't.
__package_manager__="$1"
nvim-setup::main "${__package_manager__}"
