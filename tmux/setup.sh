#!/bin/bash
#
# Symlinks `$DOTFILES/tmux/dots/tmux.conf` to `~/.tmux.conf`.
# NOTE: Forcefully and silently pre-existing files or symlinks!

tpm::main() {
    local src="$HOME/src"
    local repo_url="https://github.com/tmux-plugins/tpm.git"
    local repo_dst="$src/tpm"

    tpm::clone-repo() {
        if [[ ! -d "$src" ]]; then
            mkdir "$src"
        fi
    
        if [[ ! -d "$repo_dst" ]]; then
            git clone "$repo_url" "$repo_dst"
        fi
    }

    tpm::symlink-dotfiles() {
        local src="$repo_dst"
        local dst="$HOME/.tmux/plugins/tpm"

        if [[ -d "$dst" ]]; then
            sudo rm -rf  "$dst"
        fi

        if [[ -L "$dst" ]]; then
            rm -f  "$dst"
        fi

        if [[ ! -L "$dst" ]]; then
            ln -s "$src" "$dst"
        fi
    }

    tpm::clone-repo
    tpm::symlink-dotfiles
}



tmux::symlink-dotfiles() {
    local dots="$(realpath "$(dirname "$BASH_SOURCE")"/dots)"
    local src="$dots/tmux.conf"
    local dst="$HOME/.tmux.conf"

    if [[ -f "$dst" ]] || [[ -L "$dst" ]]; then
        rm -f "$dst"
    fi

    if [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}

tmux::main() {
    tpm::main
    tmux::symlink-dotfiles
}
tmux::main
