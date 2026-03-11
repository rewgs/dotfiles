#!/bin/bash
#
# Symlinks the files in dots dir to $HOME.

run() {
    if $DRY_RUN; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

main() {
    for file in "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/dots"/*; do
        local src
        local dst

        src="$(realpath "${file}")"
        dst="${HOME}/.$(basename "${src}")"

        if [[ -f "${dst}" ]] || [[ -L "${dst}" ]]; then
            run rm "${dst}"
        fi

        if $DRY_RUN || [[ ! -L "${dst}" ]]; then
            run ln -s "${src}" "${dst}"
            if ! $DRY_RUN; then
                echo "Symlinked:"
                echo -e "\t${src}"
                echo -e "\tto"
                echo -e "\t${dst}\n"
            fi
        fi
    done
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
