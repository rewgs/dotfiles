#!/bin/bash
#
# Symlinks dots/vimrc to ~/.vimrc.
# Run with -n/--dry-run flag to show what will happen and not actually execute.

run() {
    if $DRY_RUN; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

main() {
    local src dst
    src="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/dots/vimrc"
    dst="${HOME}/.vimrc"

    if [[ -f "${dst}" ]] || [[ -L "${dst}" ]]; then
        run rm "${dst}"
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
