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
    local dst="$zsh_plugins_dir"

    if [[ ! -d "$src" ]] || [[ ! -L "$src" ]]; then
        mkdir -p "$src"
    fi

    if [[ ! -d "$dst" ]] || [[ ! -L "$dst" ]]; then
        git clone "$repo" "$dst/$name"
    fi
}

function clone-plugins() {
    clone-plugin "https://github.com/jimhester/per-directory-history"
    clone-plugin "https://github.com/zsh-users/zsh-completions.git"
    clone-plugin "https://github.com/quarticcat/zsh-smartcache"
    clone-plugin "https://github.com/zsh-users/zsh-syntax-highlighting"
}

# Symlinks: $DOTFILES/zsh/dots/.zshenv -> ~/.zshenv
function setup-zshenv() {
    local dots
    local src
    local dst

    src="$dots/.zshenv"
    dst="$HOME/.zshenv"

    if command -v realpath &>/dev/null; then
        dots="$(realpath "$(dirname "$BASH_SOURCE")"/dots)"
    elif command -v readlink &>/dev/null; then
        dots="$(readlink -f "$(dirname "$BASH_SOURCE")"/dots)"
    else
        exit 1
    fi

    if [[ -f "$dst" ]] || [[ -L "$dst" ]]; then
        rm -f "$dst"
    fi

    if [[ ! -f "$dst" ]] || [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}

# Symlinks: $DOTFILES/zsh/dots/conf -> $XDG_CONFIG_DIR/zsh (i.e. $ZDOTDIR)
function setup-zsh-conf() {
    local dots="$(realpath "$(dirname "$BASH_SOURCE")"/dots)"
    local src="$dots/conf"
    local dst="$HOME/.config/zsh"
    local config="$(dirname "$dst")"

    if [[ ! -d "$config" ]]; then
        mkdir "$config"
    fi

    if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
        rm -rf "$dst"
    fi

    if [[ ! -d "$dst" ]] || [[ ! -L "$dst" ]]; then
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
