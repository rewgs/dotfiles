#!/bin/bash
#
# Symlinks `$DOTFILES/tmux/dots/tmux.conf` to `~/.tmux.conf`.
# NOTE: Forcefully and silently pre-existing files or symlinks!
# TODO: This needs to match a directory to a machine's hostname, not just the dots dir.

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

        if [[ ! -d "$(dirname "$dst")" ]]; then
            mkdir -p "$(dirname "$dst")"
        fi

        if [[ ! -L "$dst" ]]; then
            ln -s "$src" "$dst"
        fi
    }

    tpm::clone-repo
    tpm::symlink-dotfiles
}



tmux::symlink-dotfiles() {
    local hostname="$HOSTNAME"
    local dots="$(realpath "$(dirname $BASH_SOURCE)/dots/$hostname")"
    local dots_dst="$HOME/.config/tmux"

    if [[ -d "$dots_dst" ]] || [[ -L "$dots_dst" ]]; then
        rm -rf "$dots_dst"
    fi

    if  [[ ! -L "$dots_dst" ]]; then
        # echo -e "Symlinking $dots to $dots_dst"
        ln -s "$dots" "$dots_dst"
    fi

    local src="$dots_dst/tmux.conf"
    local dst="$HOME/.tmux.conf"

    if [[ -f "$dst" ]] || [[ -L "$dst" ]]; then
        rm -f "$dst"
    fi

    if [[ ! -L "$dst" ]]; then
        # echo -e "Symlinking $src to $dst"
        ln -s "$src" "$dst"
    fi
}

tmux::main() {
    tpm::main
    tmux::symlink-dotfiles
}
tmux::main
