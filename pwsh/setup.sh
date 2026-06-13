#!/bin/bash
#
# Runs setup.ps1.

if ! command -v pwsh >/dev/null 2>&1; then
    echo "Error: pwsh (PowerShell Core) is not installed or not on PATH." >&2
    exit 1
fi

pwsh -File "$(dirname "$(realpath "${BASH_SOURCE}")")/setup.ps1"
