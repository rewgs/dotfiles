#!/bin/bash
#
# Symlinks ideavimrc to ~/.ideavimrc so every JetBrains IDE (via the IdeaVim
# plugin) reads its vim bindings straight from this repo.
#
# NOTE: This only covers the IdeaVim layer. Native JetBrains keymaps
# (Settings > Keymap) are owned by JetBrains Settings Sync and are NOT
# managed here -- see this directory's notes before changing that.
#
# Run with -n/--dry-run to show what would happen without executing.

run() {
    if $DRY_RUN; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

main() {
    local src dst
    src="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/ideavimrc"
    dst="${HOME}/.ideavimrc"

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
