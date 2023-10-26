#!/usr/bin/env bash

# Not sure why this isn't working. Just freezes. Ctrl+c throws a warning about how `apt` doesn't 
# have a stable CLI interface, which tells me that this is indeed running the `apt` commands. So 
# why is it freezing?
function step_1 () {
    current=$(pwd)
    log_file="$current/installation_log.txt"

    cd "$current" || return
    source ./utils.sh
    source ./apps.sh
    if [ "$(install_apps_from_package_manager)" = "success" ]; then
        echo "Success: install_apps_from_package_manager()" | cat >> "$log_file"
    else
        echo "Failure: install_apps_from_package_manager()" | cat >> "$log_file"
    fi
}

step_1
