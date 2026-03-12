#!/bin/bash
#
# Sets up btop config for the current machine.
#
# - Machine-specific configs are stored in dots/<hostname>/btop.conf
# - Themes are shared across all machines in dots/themes/
# - If no config exists for the current hostname, prompts the user to use or copy an existing one
#
# Run with -n/--dry-run flag to show what will happen without executing.

run() {
    if $DRY_RUN; then
        echo "[dry-run] $*"
    else
        "$@"
    fi
}

# Tab-completion handler used by bind -x during config selection.
# Reads from the global _BTOP_CONFIGS array.
_btop_tab_complete() {
    local -a matches
    mapfile -t matches < <(compgen -W "${_BTOP_CONFIGS[*]}" -- "${READLINE_LINE}")
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
    local dots_dir
    dots_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")/dots"

    local host_dir="${dots_dir}/${HOSTNAME}"
    local themes_dir="${dots_dir}/themes"

    # Check for machine-specific config directory
    if [[ ! -d "${host_dir}" ]]; then
        echo "No config found for hostname '${HOSTNAME}'."
        echo "Available configs:"
        for dir in "${dots_dir}"/*/; do
            local name
            name="$(basename "${dir}")"
            # Skip the shared themes directory
            [[ "${name}" == "themes" ]] && continue
            echo "  ${name}"
        done
        echo

        # Populate global for _btop_tab_complete, then bind tab to it.
        _BTOP_CONFIGS=()
        for dir in "${dots_dir}"/*/; do
            local name
            name="$(basename "${dir}")"
            [[ "${name}" == "themes" ]] && continue
            _BTOP_CONFIGS+=("${name}")
        done
        bind -x '"\t":_btop_tab_complete' 2>/dev/null

        local chosen
        read -re -p "Which config to use as a base? " chosen

        bind '"\t":complete' 2>/dev/null
        unset _BTOP_CONFIGS

        if [[ ! -d "${dots_dir}/${chosen}" ]]; then
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
            run cp -r "${dots_dir}/${chosen}" "${host_dir}"
        else
            host_dir="${dots_dir}/${chosen}"
        fi
    fi

    local dst="${HOME}/.config/btop"

    # Remove existing btop config (symlink or directory)
    if [[ -L "${dst}" ]]; then
        run rm "${dst}"
    elif [[ -d "${dst}" ]]; then
        echo "Warning: ${dst} is a real directory, not a symlink. Removing it."
        run rm -rf "${dst}"
    fi

    # Create the btop config directory
    run mkdir -p "${dst}"

    # Symlink the machine-specific config file
    local config_src="${host_dir}/btop.conf"
    local config_dst="${dst}/btop.conf"
    run ln -s "${config_src}" "${config_dst}"

    # Symlink the shared themes directory
    local themes_dst="${dst}/themes"
    run ln -s "${themes_dir}" "${themes_dst}"

    if ! $DRY_RUN; then
        echo "Setup complete:"
        echo -e "\tConfig: ${config_src}"
        echo -e "\t     -> ${config_dst}"
        echo -e "\tThemes: ${themes_dir}"
        echo -e "\t     -> ${themes_dst}"
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
