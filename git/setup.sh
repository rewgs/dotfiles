#!/bin/bash
#
# Symlinks `config` to `~/.gitconfig`, and `ignore` to `~/.config/git/ignore`.


symlink_dotfile() {
    local src="$1"
    local dst="$2"

    if [[ -L "$dst" ]] || [[ -f "$dst" ]]; then 
        rm -f "$dst"
    fi

    if [[ ! -L "$dst" ]] || [[ ! -f "$dst" ]]; then
        echo "Symlinking $src to $dst"
        ln -s "$src" "$dst"
    fi
}

symlink_config() {
    local dots="$(realpath "$(dirname "$BASH_SOURCE")/dots")"
    local src="$dots/config"
    local dst="$HOME/.gitconfig"

    symlink_dotfile "$src" "$dst"
}

symlink_ignore() {
    local dots="$(realpath "$(dirname "$BASH_SOURCE")/dots")"
    local src="$dots/ignore"
    local dst="$HOME/.gitignore"

    symlink_dotfile "$src" "$dst"
}

main() {
    symlink_config
    symlink_ignore
}
main
