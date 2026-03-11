#!/bin/bash
#
# Sets up zsh: symlinks .zshenv to $HOME and dots/conf to ~/.config/zsh, and
# clones plugins to ~/src/zsh-plugins.
# Run with -n/--dry-run flag to show what will happen and not actually execute.

run() {
    if $DRY_RUN; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

setup_plugins() {
    local plugins_dir="${HOME}/src/zsh-plugins"

    if [[ ! -d "${plugins_dir}" ]]; then
        run mkdir -p "${plugins_dir}"
    fi

    local -a plugins=(
        "https://github.com/jimhester/per-directory-history"
        "https://github.com/zsh-users/zsh-completions.git"
        "https://github.com/quarticcat/zsh-smartcache"
        "https://github.com/zsh-users/zsh-syntax-highlighting"
    )

    for repo in "${plugins[@]}"; do
        local name="${repo##*/}"
        local dst="${plugins_dir}/${name}"

        if [[ -d "${dst}" ]]; then
            echo "${name} already cloned, skipping."
        else
            run git clone "${repo}" "${dst}"
        fi
    done
}

setup_zshenv() {
    local src dst
    src="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/dots/.zshenv"
    dst="${HOME}/.zshenv"

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

setup_conf() {
    local src dst
    src="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/dots/conf"
    dst="${HOME}/.config/zsh"

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

main() {
    setup_plugins
    setup_zshenv
    setup_conf
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
