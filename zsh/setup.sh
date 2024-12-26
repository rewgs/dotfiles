#!/bin/bash
#
# Setups up all zsh dotfiles, as well as all plugins.

zsh_plugins_dir="$HOME/src/zsh-plugins"

setup-zsh::check-plugins-dir() {
    if [[ ! -d "$zsh_plugins_dir" ]]; then
        mkdir -p "$zsh_plugins_dir"
    fi
}

setup-zsh::clone-plugin() {
    local repo="$1"
    local src="$HOME/src"
    local dst="$zsh_plugins_dir"

    if [[ ! -d "$src" ]] || [[ ! -L "$src" ]]; then
        mkdir -p "$src"
    fi

    if [[ ! -d "$dst" ]] || [[ ! -L "$dst" ]]; then
        git clone "$repo" "$dst"
    fi
}

setup-zsh::clone-plugins() {
    setup-zsh::clone-plugin "https://github.com/zsh-users/zsh-syntax-highlighting"
    setup-zsh::clone-plugin "https://github.com/quarticcat/zsh-smartcache"
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

setup-zsh::main() {
    setup-zsh::check-plugins-dir
    setup-zsh::clone-plugins
    setup-zsh::zshenv
    setup-zsh::conf
}
setup-zsh::main
