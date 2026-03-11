#!/bin/bash
#
# Sets up tmux:
# - Finds the subdirectory in dots that matches $HOSTNAME; prompts if not found.
# - Symlinks the matching dots dir to ~/.config/tmux.
# - Symlinks ~/.config/tmux/tmux.conf to ~/.tmux.conf.
# - Clones tpm directly to ~/.tmux/plugins/tpm if not already present.
#
# Run with -n/--dry-run flag to show what will happen and not actually execute.

run() {
    if $DRY_RUN; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

# Tab-completion handler used by bind -x during config selection.
# Reads from the global _TMUX_CONFIGS array.
_tmux_tab_complete() {
    local -a matches
    mapfile -t matches < <(compgen -W "${_TMUX_CONFIGS[*]}" -- "${READLINE_LINE}")
    if [[ ${#matches[@]} -eq 1 ]]; then
        READLINE_LINE="${matches[0]}"
        READLINE_POINT=${#READLINE_LINE}
    elif [[ ${#matches[@]} -gt 1 ]]; then
        echo
        printf '  %s\n' "${matches[@]}"
        echo -n "Which config to use as a base? ${READLINE_LINE}"
    fi
}

setup_config() {
    local dots_dir="$1"
    local host_dir="${dots_dir}/${HOSTNAME}"

    if [[ ! -d "${host_dir}" ]]; then
        echo "No config found for hostname '${HOSTNAME}'."
        echo "Available configs:"
        for dir in "${dots_dir}"/*/; do
            echo "  $(basename "${dir}")"
        done
        echo

        _TMUX_CONFIGS=()
        for dir in "${dots_dir}"/*/; do
            _TMUX_CONFIGS+=("$(basename "${dir}")")
        done
        bind -x '"\t":_tmux_tab_complete' 2>/dev/null

        local chosen
        read -re -p "Which config to use as a base? " chosen

        bind '"\t":complete' 2>/dev/null
        unset _TMUX_CONFIGS

        if [[ ! -d "${dots_dir}/${chosen}" ]]; then
            echo "Invalid choice '${chosen}'. Exiting."
            exit 1
        fi

        local action
        while true; do
            read -rp "Use '${chosen}' as-is, or copy it to create a new config for '${HOSTNAME}'? [use/copy] " action
            case "${action}" in
            use) break ;;
            copy) break ;;
            *) echo "Please enter 'use' or 'copy'." ;;
            esac
        done

        if [[ "${action}" == "copy" ]]; then
            echo "Copying '${chosen}' config to '${HOSTNAME}'..."
            run cp -r "${dots_dir}/${chosen}" "${host_dir}"
        else
            host_dir="${dots_dir}/${chosen}"
        fi
    fi

    local config_dst="${HOME}/.config/tmux"

    if [[ -L "${config_dst}" ]] || [[ -f "${config_dst}" ]]; then
        run rm "${config_dst}"
    elif [[ -d "${config_dst}" ]]; then
        echo "Warning: ${config_dst} is a real directory, not a symlink. Removing it."
        run rm -rf "${config_dst}"
    fi

    run ln -s "${host_dir}" "${config_dst}"

    if ! $DRY_RUN; then
        echo "Symlinked:"
        echo -e "\t${host_dir}"
        echo -e "\tto"
        echo -e "\t${config_dst}"
    fi

    local conf_dst="${HOME}/.tmux.conf"

    if [[ -L "${conf_dst}" ]] || [[ -f "${conf_dst}" ]]; then
        run rm "${conf_dst}"
    fi

    run ln -s "${config_dst}/tmux.conf" "${conf_dst}"

    if ! $DRY_RUN; then
        echo "Symlinked:"
        echo -e "\t${config_dst}/tmux.conf"
        echo -e "\tto"
        echo -e "\t${conf_dst}"
    fi
}

setup_tpm() {
    local tpm_dst="${HOME}/.tmux/plugins/tpm"
    local tpm_url="https://github.com/tmux-plugins/tpm.git"

    if [[ ! -d "$(dirname "${tpm_dst}")" ]]; then
        run mkdir -p "$(dirname "${tpm_dst}")"
    fi

    if [[ -d "${tpm_dst}" ]] && [[ ! -L "${tpm_dst}" ]]; then
        echo "tpm already installed at ${tpm_dst}, skipping."
        return
    fi

    if [[ -L "${tpm_dst}" ]] || [[ -f "${tpm_dst}" ]]; then
        echo "Removing old tpm symlink at ${tpm_dst}..."
        run rm "${tpm_dst}"
    fi

    run git clone "${tpm_url}" "${tpm_dst}"

    if ! $DRY_RUN; then
        echo "Cloned tpm to ${tpm_dst}"
    fi
}

main() {
    local dots_dir
    dots_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/dots"

    setup_config "${dots_dir}"
    echo
    setup_tpm
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
