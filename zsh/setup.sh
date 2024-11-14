#!/bin/bash
#
# Setups up all zsh dotfiles, as well as all plugins.

setup-zsh::plugins-dir() {
    local dir="$HOME/src/zsh-plugins"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
    fi
}

# Symlinks: $DOTFILES/zsh/dots/.zshenv -> ~/.zshenv
setup-zsh::zshenv() {
    local dots="$(realpath "$(dirname "$BASH_SOURCE")"/dots)"
    local src="$dots/.zshenv"
    local dst="$HOME/.zshenv"

    if [[ -f "$dst" ]] || [[ -L "$dst" ]]; then
        rm -f "$dst"
    fi

    if [[ ! -f "$dst" ]] || [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}

# Symlinks: $DOTFILES/zsh/dots/conf -> $XDG_CONFIG_DIR/zsh (i.e. $ZDOTDIR)
setup-zsh::conf() {
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

# Sources all plugins setup files.
setup-zsh::plugins() {
    local plugins="$(realpath "$(dirname "$BASH_SOURCE")"/plugins)"
    for file in "$plugins"/*; do
        source "$file"
    done
}

setup-zsh::main() {
    setup-zsh::plugins-dir
    setup-zsh::plugins
    setup-zsh::zshenv
    setup-zsh::conf
}
setup-zsh::main
