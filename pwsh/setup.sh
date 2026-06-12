#!/bin/bash
#
# Symlinks `dots` dir to `~/.config/powershell`
# src="$(dirname "$(realpath "${BASH_SOURCE}")")/dots"
# dst="$HOME/.config/powershell"
#
# # Ensure the parent dir exists, otherwise `ln -s` fails on a bare machine.
# mkdir -p "$(dirname "$dst")"
#
# if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then
#     rm -rf "$dst"
# fi
#
# if [[ ! -L "$dst" ]]; then
#     ln -s "$src" "$dst"
# fi
#
#

if ! command -v pwsh >/dev/null 2>&1; then
    echo "Error: pwsh (PowerShell Core) is not installed or not on PATH." >&2
    exit 1
fi

pwsh -File "$(dirname "$(realpath "${BASH_SOURCE}")")/setup.ps1"

