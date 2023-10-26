#!/usr/bin/env bash

function step_1 () {
    current=$(pwd)
    log_file="$current/installation_log.txt"

    cd "$current" || return
    source ./apps.sh
    if [ "$(install_apps_from_package_manager)" = "success" ]; then
        echo "Success: install_apps_from_package_manager()" | cat >> "$log_file"
    fi
}

step_1
