#!/usr/bin/env zsh
#
# Sets up hammerspoon dotfiles.
# Requires to be run with zsh, as this script relies on the $DOTFILES env var.


verify_spoons () {
    local repo="https://github.com/Hammerspoon/Spoons.git"
    local src="$HOME/src"
    local dst="${src}/Spoons"

    if [[ ! -d "$src" ]]; then mkdir "$src"; fi

    if [[ ! -d "$dst" ]]; then
        cd "$src" || return
        git clone --depth 1 "$repo"
    fi

    if [[ -d "${dst}/Spoons" ]]; then
        true; return
    else
        false; return
    fi
}


setup () {
    local src="$DOTFILES/hammerspoon/hs-config"
    local dst="$HOME/.hammerspoon"

    if [[ ! -d "$src" ]]; then exit; fi
    if [[ ! -d "$dst" ]]; then mkdir "$dst"; fi

    # symlink dotfiles
    dotfiles=("$src/"*.lua)
    for d in "${dotfiles[@]}"; do
        local dotfile=$(realpath "$d")
        local dotname=$(basename "$dotfile")
        local dot_dst="${dst}/${dotname}"

        if [[ ! -L "$dot_dst" ]]; then
            echo "Linking:"
            echo "\t{$dotfile}"
            echo "\tto:"
            echo "\t{$dot_dst}"
            ln -s "$dotfile" "$dot_dst"
        else
            echo "Symlink ${dot_dst} already exists. Skipping."
        fi
    done

    # symlink Spoons
    if $(verify_spoons); then
        if [[ ! -L "${dst}/Spoons" ]]; then
            echo "Linking:"
            echo "\t$HOME/src/Spoons/Spoons}"
            echo "\tto:"
            echo "\t${dst}/Spoons"
            ln -s "$HOME/src/Spoons/Spoons" "${dst}/Spoons"
        else
            echo "Symlink ${dst}/Spoons already exists. Skipping "
        fi
    else
        echo "$HOME/Spoons repo does not exist and could not be cloned. Hammerspoon won't work correctly without this!"
    fi
}
setup
