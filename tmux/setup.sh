#!/bin/bash
#
# Symlinks:
#   $DOTFILES/tmux/dots/tmux.conf -> $HOME/.tmux.conf
#   $HOME/src/tpm -> $HOME/.tmux/plugins/tpm


setup::tmux() {
    local this_repo
    local dots
    local src
    local dst

    this_repo="$(realpath "$(dirname "${BASH_SOURCE}")")"
    dots="$(realpath "${this_repo}/dots")"
    src="$(realpath "${dots}/tmux.conf")"
    dst="${HOME}/.tmux.conf"

    # echo "This repo: ${this_repo}"
    # echo "Dots dir: ${dots}"
    # echo "Src: ${src}"
    # echo "Dst: ${dst}"

    if [[ -f "${dst}" ]] || [[ -L "${dst}" ]]; then
        # NOTE: This deletes the symlink or original file silently!
        rm -f "${dst}"
    fi

    if [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}


setup::tpm() {
    local src
    local dst

    src="$(realpath "${HOME}/src/tpm")"
    dst="${HOME}/.tmux/plugins/tpm"

    # echo "Src: ${src}"
    # echo "Dst: ${dst}"

    if [[ ! -d "$(dirname "${src}")" ]]; then
        mkdir -p "$(dirname "${src}")"
    fi

    if [[ ! -d "$(dirname "${dst}")" ]]; then
        mkdir -p "$(dirname "${dst}")"
    fi

    if [[ ! -d "${src}" ]]; then
        echo "tpm not found! Cloning repo to ${src}..."
        git clone https://github.com/tmux-plugins/tpm.git "${src}"
    fi

    if [[ -d "${dst}" ]] || [[ -L "${dst}" ]]; then
        # NOTE: This deletes the symlink or original directory silently!
        rm -rf "${dst}"
    fi

    if [[ ! -L "${dst}" ]]; then
        ln -s "${src}" "${dst}"
    fi
}


setup::main() {
    setup::tmux
    setup::tpm
}
setup::main
