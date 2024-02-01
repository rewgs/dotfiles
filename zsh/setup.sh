#!/bin/bash


setup () {
    local THIS_DIR=$(realpath $(pwd))
    local src=$(realpath "$THIS_DIR/dots")
    local dst="$HOME"

    local dotfiles=(
        "zlogin"
        "zlogout"
        "zprofile"
        "zshenv"
        "zshrc"
    )

    declare -a already_present=()
    for d in "${dotfiles[@]}"; do
        local dotfile_src="${src}/${d}"
        local dotfile_dst="${dst}/.${d}"

        if [[ -L "$dotfile_dst" ]]; then
            already_present+=("$dotfile_dst")
        fi

        if [[ ${#dotfiles[@]} == ${#already_present[@]} ]]; then
            echo "All dotfiles are already symlinked! Relink?"
        fi

        echo "Symlinking $dotfile_src to $dotfile_dst"
        # ln -s "$dotfile_src" "$dotfile_dst"
    done

    local conf_src="${src}/conf"
    local conf_dst="$HOME/.config"
    if [[ ! -d "$conf_dst" ]]; then
        mkdir -p "$conf_dst"
    fi

    echo "Symlinking $conf_src to $conf_dst/zsh"
    # ln -s "$conf_src" "${conf_dst}/zsh"
}
setup
