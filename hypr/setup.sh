#!/bin/bash
#
# Ensures that all files in `common/` are symlinked to directory named $HOSTNAME.
# Symlinks $HOSTNAME dir to ~/.config/hypr


# TODO: Add files to exclude (e.g. hypridle, hyprlock, hyprpaper)
# TODO: Use relative path to common files instead of absolute.
hyprland::symlink-common() {
    local src_dir="$(realpath $(dirname "${BASH_SOURCE}"))/dots/common"
    local dst_dir="$(realpath $(dirname "${BASH_SOURCE}"))/dots/$HOSTNAME"

    # echo "src_dir: $src_dir"
    # echo "dst_dir: $dst_dir"

    for src_file in "$src_dir"/*; do
        local src="$src_dir/$(basename $src_file)"
        # echo "src: $src"

        for dst_file in "$dst_dir"/*; do
            local old_dst="$dst_dir/$(basename $dst_file)"
            local new_dst="$dst_dir/$(basename $src_file)"

            # echo "old_dst: $old_dst"
            # echo "new_dst: $new_dst"

            # Delete the old symlinks.
            if [[ "$(basename $src)" == "$(basename $old_dst)" ]] && [[ -L "$old_dst" ]]; then
                # echo "These match:"
                # echo "$src"
                # echo "$old_dst"
                # echo "Deleting $old_dst"
                # echo ""
                rm -i "$old_dst"
            fi

            if [[ ! -L "$new_dst" ]]; then
                ln -s "$src" "$new_dst"
                echo "Symlinked $src to $new_dst!"
            fi
        done
    done
}


hyprland::symlink-dirs() {
    local src="$(realpath $(dirname "${BASH_SOURCE}"))/dots/$HOSTNAME"
    local dst="$HOME/.config/hypr"

    if [[ ! -d "$(dirname "$dst")" ]]; then
        mkdir "$(dirname "$dst")"
    fi

    if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
        rm -rf "$dst"
    fi

    if [[ ! -L "$dst" ]]; then
        ln -s "$src" "$dst"
    fi
}


hyprland::symlink-dirs
hyprland::symlink-common
