#!/bin/bash
#
# Finds the subdirectory in dots that matches the current machine's $HOSTNAME; if not found, prompts the user which machine's config to use, with an option to copy it and create a new config for the current machine. Symlinks the (sub)directory containing fuzzel.ini to ~/.config/fuzzel.
#
# Note that some machines contain multiple configs for different situations (e.g. rewgs-x1c11's "docked" and "laptop" -- these use different font sizes/etc for if using the built-in laptop display or a larger external display; kanshi changes which config is used depending on the display state, but the "laptop" option is always selected by this script).
#
# Run with -n/--dry-run flag to show what will happen and not actually execute.

run() {
    if $DRY_RUN; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

main() {
    local dots_dir
    dots_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/dots"

    local host_dir="${dots_dir}/${HOSTNAME}"

    if [[ ! -d "${host_dir}" ]]; then
        echo "No config found for hostname '${HOSTNAME}'."
        echo "Available configs:"
        for dir in "${dots_dir}"/*/; do
            echo "  $(basename "${dir}")"
        done

        local chosen
        read -rp "Which config to use as a base? " chosen

        if [[ ! -d "${dots_dir}/${chosen}" ]]; then
            echo "Invalid choice '${chosen}'. Exiting."
            exit 1
        fi

        echo "Copying '${chosen}' config to new directory '${HOSTNAME}'..."
        run cp -r "${dots_dir}/${chosen}" "${host_dir}"
    fi

    local src
    if [[ -d "${host_dir}/laptop" ]]; then
        src="${host_dir}/laptop"
    else
        src="${host_dir}"
    fi

    local dst="${HOME}/.config/fuzzel"

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
