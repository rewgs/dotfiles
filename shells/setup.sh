#!/bin/bash

SHELLS_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

usage() {
    cat <<EOF
Usage: $(basename "$0") [--bash] [--sh] [--zsh] [--all] [-n|--dry-run] [-h|--help]

  --bash        Set up bash
  --sh          Set up sh
  --zsh         Set up zsh
  --all         Set up all shells (bash, sh, zsh)
  -n, --dry-run Show what would be done without executing
  -h, --help    Show this help
EOF
    exit "${1:-1}"
}

run_setup() {
    local shell="$1"
    local script="$SHELLS_DIR/$shell/setup.sh"

    if [[ ! -f "$script" ]]; then
        echo "Error: no setup script found for $shell at $script" >&2
        return 1
    fi

    echo "=== Setting up $shell ==="
    if $DRY_RUN; then
        "$script" --dry-run
    else
        "$script"
    fi
    echo ""
}

DO_BASH=false
DO_SH=false
DO_ZSH=false
DRY_RUN=false

[[ $# -eq 0 ]] && usage

while [[ "$1" == -* ]]; do
    case "$1" in
        --bash)          DO_BASH=true ;;
        --sh)            DO_SH=true ;;
        --zsh)           DO_ZSH=true ;;
        --all)           DO_BASH=true; DO_SH=true; DO_ZSH=true ;;
        -n | --dry-run)  DRY_RUN=true ;;
        -h | --help)     usage 0 ;;
        *)               echo "Unknown option: $1" >&2; usage ;;
    esac
    shift
done

! $DO_BASH && ! $DO_SH && ! $DO_ZSH && usage

$DRY_RUN && echo "NOTE: This is a dry-run. No changes will be made." && echo ""

$DO_BASH && run_setup bash
$DO_SH   && run_setup sh
$DO_ZSH  && run_setup zsh
