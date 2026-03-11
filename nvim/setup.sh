#!/bin/bash
#
# Symlinks the dots dir to ~/.config/nvim.
# Run with -n/--dry-run flag to show what will happen and not actually execute.

run() {
    if $DRY_RUN; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

main() {
    local src
    src="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/dots"

    local dst="${HOME}/.config/nvim"

    if [[ ! -d "$(dirname "${dst}")" ]]; then
        run mkdir -p "$(dirname "${dst}")"
    fi

    if [[ -L "${dst}" ]] || [[ -f "${dst}" ]]; then
        run rm "${dst}"
    elif [[ -d "${dst}" ]]; then
        echo "Warning: ${dst} is a real directory, not a symlink. Removing it."
        run rm -rf "${dst}"
    fi

    run ln -s "${src}" "${dst}"

    if ! $DRY_RUN; then
        echo "Symlinked:"
        echo -e "\t${src}"
        echo -e "\tto"
        echo -e "\t${dst}"
    fi
}

DRY_RUN=false

while [[ "$1" == -* ]]; do
    case "$1" in
    -n | --dry-run) DRY_RUN=true ;;
    esac
    shift
done

$DRY_RUN && echo "NOTE: This is a dry-run. No changes will be made."

main
