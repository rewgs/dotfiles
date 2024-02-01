#!/bin/bash


setup () {
    local THIS_DIR=$(realpath $(pwd))
    local src="$THIS_DIR"
    local dst="$HOME"

    local dotfiles=(
        "bash_profile"
        "bashrc"
        "inputrc"
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

        # echo "Symlinking $dotfile_src to $dotfile_dst"
        # ln -s "$dotfile_src" "$dotfile_dst"
    done

    echo "Symlinking $conf_src to $conf_dst/zsh"
    # ln -s "$conf_src" "${conf_dst}/zsh"
}
