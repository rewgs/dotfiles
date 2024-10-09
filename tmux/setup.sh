#!/bin/bash
#
# Symlinks `$DOTFILES/tmux/dots/tmux.conf` to `~/.tmux.conf`.

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
            echo "Cloned tpm repo to $repo_dst!"
            return 0
        fi
    }

    tpm::symlink-dotfiles() {
        local src="$repo_dst"
        local dst="$HOME/.tmux/plugins/tpm"

        # TODO: left off here
        # if [[ ! -d]]
    }

    tpm::clone-repo
    tpm::symlink-dotfiles
}



tmux::symlink-dotfiles() {
    local dots="$(realpath "$(dirname "$BASH_SOURCE")"/dots)"
    local src="$dots/tmux.conf"
    local dst="$HOME/.tmux.conf"

    if [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
        echo "Symlinked $src to $dst!"
    else
        echo "$src already symlinked to $dst!"
    fi
}
