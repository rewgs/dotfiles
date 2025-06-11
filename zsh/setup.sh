#!/bin/bash
#
# Setups up all zsh dotfiles, as well as all plugins.

zsh_plugins_dir="$HOME/src/zsh-plugins"

function check-plugins-dir() {
    if [[ ! -d "$zsh_plugins_dir" ]]; then
        mkdir -p "$zsh_plugins_dir"
    fi
}

function clone-plugin() {
    local repo="$1"
    local name="${repo##*/}" # Trims the last part of the URL, i.e. the name of the repo
    local src="$HOME/src"
    local dst="$zsh_plugins_dir/$name"

    if [[ ! -d "$src" ]] || [[ ! -L "$src" ]]; then
        mkdir -p "$src"
    fi

    if [[ ! -d "$dst" ]] || [[ ! -L "$dst" ]]; then
        git clone "$repo" "$dst"
    fi
}

function clone-plugins() {
    clone-plugin "https://github.com/jimhester/per-directory-history"
    clone-plugin "https://github.com/zsh-users/zsh-completions.git"
    clone-plugin "https://github.com/quarticcat/zsh-smartcache"
    clone-plugin "https://github.com/zsh-users/zsh-syntax-highlighting"
}

function get-dots-path() {
    local dots

    if ! command -v realpath &>/dev/null; then
        dots="$(readlink -f "$(dirname "$BASH_SOURCE")"/dots)"
    else
        dots="$(realpath "$(dirname "$BASH_SOURCE")"/dots)"
    fi

    echo "$dots"
}

# Symlinks: $DOTFILES/zsh/dots/.zshenv -> ~/.zshenv
function setup-zshenv() {
    local src
    local dst

    src="$(get-dots-path)/.zshenv"
    dst="$HOME/.zshenv"

    if [[ -f "$dst" ]] || [[ -L "$dst" ]]; then
        rm -f "$dst"
    fi

    if [[ ! -f "$dst" ]] || [[ ! -L "$dst" ]]; then
        echo -e "\nLinking:"
        echo -e "\t$src"
        echo -e "\tto"
        echo -e "\t$dst\n"
        ln -s "$src" "$dst"
    fi
}

# Symlinks: $DOTFILES/zsh/dots/conf -> $XDG_CONFIG_DIR/zsh (i.e. $ZDOTDIR)
function setup-zsh-conf() {
    local src
    local dst
    local config

    src="$(get-dots-path)/conf"
    dst="$HOME/.config/zsh"

    config="$(dirname "$dst")"

    if [[ ! -d "$config" ]]; then
        mkdir "$config"
    fi

    if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
        rm -rf "$dst"
    fi

    if [[ ! -d "$dst" ]] || [[ ! -L "$dst" ]]; then
        echo -e "\nLinking:"
        echo -e "\t$src"
        echo -e "\tto"
        echo -e "\t$dst\n"
        ln -s "$src" "$dst"
    fi
}

function main() {
    check-plugins-dir
    clone-plugins
    setup-zshenv
    setup-zsh-conf
}
main
