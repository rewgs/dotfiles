#!/bin/bash
#
# Sets up neovim:
# - Finds the subdirectory in dots/lua/machines that matches $HOSTNAME; prompts if not found, with
#   an option to use an existing machine's config as-is or copy it to create a new one.
# - Symlinks the dots dir to ~/.config/nvim.
# - Symlinks the chosen dots/lua/machines/<hostname> dir to dots/lua/plugins/machine.
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
# Reads from the global _NVIM_CONFIGS array.
_nvim_tab_complete() {
    local -a matches
    mapfile -t matches < <(compgen -W "${_NVIM_CONFIGS[*]}" -- "${READLINE_LINE}")
    if [[ ${#matches[@]} -eq 1 ]]; then
        READLINE_LINE="${matches[0]}"
        READLINE_POINT=${#READLINE_LINE}
    elif [[ ${#matches[@]} -gt 1 ]]; then
        echo
        printf '  %s\n' "${matches[@]}"
        echo -n "Which config to use as a base? ${READLINE_LINE}"
    fi
}

main() {
    local script_dir
    script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

    local dots_dir="${script_dir}/dots"
    local machines_dir="${dots_dir}/lua/machines"
    local machine_dir="${machines_dir}/${HOSTNAME}"

    if [[ ! -d "${machine_dir}" ]]; then
        echo "No config found for hostname '${HOSTNAME}'."
        echo "Available configs:"
        for dir in "${machines_dir}"/*/; do
            echo "  $(basename "${dir}")"
        done
        echo

        _NVIM_CONFIGS=()
        for dir in "${machines_dir}"/*/; do
            _NVIM_CONFIGS+=("$(basename "${dir}")")
        done
        bind -x '"\t":_nvim_tab_complete' 2>/dev/null

        local chosen
        read -re -p "Which config to use as a base? " chosen

        bind '"\t":complete' 2>/dev/null
        unset _NVIM_CONFIGS

        if [[ ! -d "${machines_dir}/${chosen}" ]]; then
            echo "Invalid choice '${chosen}'. Exiting."
            exit 1
        fi

        local action
        while true; do
            read -rp "Use '${chosen}' as-is, or copy it to create a new config for '${HOSTNAME}'? [use/copy] " action
            case "${action}" in
                use)  break ;;
                copy) break ;;
                *)    echo "Please enter 'use' or 'copy'." ;;
            esac
        done

        if [[ "${action}" == "copy" ]]; then
            echo "Copying '${chosen}' config to '${HOSTNAME}'..."
            run cp -r "${machines_dir}/${chosen}" "${machine_dir}"
        else
            machine_dir="${machines_dir}/${chosen}"
        fi
    fi

    # Symlink dots/ to ~/.config/nvim
    local nvim_dst="${HOME}/.config/nvim"

    if [[ ! -d "$(dirname "${nvim_dst}")" ]]; then
        run mkdir -p "$(dirname "${nvim_dst}")"
    fi

    if [[ -L "${nvim_dst}" ]] || [[ -f "${nvim_dst}" ]]; then
        run rm "${nvim_dst}"
    elif [[ -d "${nvim_dst}" ]]; then
        echo "Warning: ${nvim_dst} is a real directory, not a symlink. Removing it."
        run rm -rf "${nvim_dst}"
    fi

    run ln -s "${dots_dir}" "${nvim_dst}"

    if ! $DRY_RUN; then
        echo "Symlinked:"
        echo -e "\t${dots_dir}"
        echo -e "\tto"
        echo -e "\t${nvim_dst}"
    fi

    # Symlink machines/<hostname> to dots/lua/plugins/machine
    local machine_link="${dots_dir}/lua/plugins/machine"

    if [[ -L "${machine_link}" ]] || [[ -f "${machine_link}" ]]; then
        run rm "${machine_link}"
    elif [[ -d "${machine_link}" ]] && [[ ! -L "${machine_link}" ]]; then
        echo "Warning: ${machine_link} is a real directory. Removing it."
        run rm -rf "${machine_link}"
    fi

    run ln -s "${machine_dir}" "${machine_link}"

    if ! $DRY_RUN; then
        echo "Symlinked:"
        echo -e "\t${machine_dir}"
        echo -e "\tto"
        echo -e "\t${machine_link}"
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
