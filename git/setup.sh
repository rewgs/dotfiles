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
    local src="$1/config"
    local dst="$HOME/.gitconfig"

    symlink_dotfile "$src" "$dst"
}

symlink_ignore() {
    local src="$1/ignore"
    local dst="$HOME/.config/git/ignore"
    local dst_parent="$(dirname "$dst")"
    if [[ ! -d "$dst_parent" ]]; then
        mkdir -p "$dst_parent"
    fi

    symlink_dotfile "$src" "$dst"
}

main() {
    local dots="$(realpath "$(dirname "$BASH_SOURCE")/dots")"
    symlink_config "$dots"
    symlink_ignore "$dots"
}
main
