#!/bin/sh
#
# Symlinks the files in dots dir to $HOME.
# Run with -n/--dry-run flag to show what will happen and not actually execute.

run() {
    if [ "$DRY_RUN" = "true" ]; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

main() {
    dots_dir="$(dirname "$(realpath "$0")")/dots"

    for file in "$dots_dir"/*; do
        src="$(realpath "$file")"
        dst="$HOME/.$(basename "$src")"

        if [ -f "$dst" ] || [ -L "$dst" ]; then
            run rm "$dst"
        fi

        if [ "$DRY_RUN" = "true" ] || [ ! -L "$dst" ]; then
            run ln -s "$src" "$dst"
            if [ "$DRY_RUN" != "true" ]; then
                printf "Symlinked:\n\t%s\n\tto\n\t%s\n\n" "$src" "$dst"
            fi
        fi
    done
}

DRY_RUN=false

while [ "${1#-}" != "$1" ]; do
    case "$1" in
        -n | --dry-run) DRY_RUN=true ;;
    esac
    shift
done

[ "$DRY_RUN" = "true" ] && echo "NOTE: This is a dry-run. No changes will be made."

main
