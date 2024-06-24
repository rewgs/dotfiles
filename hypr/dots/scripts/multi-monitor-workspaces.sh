#!/bin/bash
#
# Switches active workspace on all connected external monitors.

multi-monitor-workspaces::main() {
    local next_workspace="$1"

    local total_num_workspaces=10 # TODO: somehow get this number dynamically
    local num_active_workspaces="$(hyprctl workspaces | grep -c 'workspace')"
    local num_monitors="$(hyprctl monitors | grep -c 'Monitor')"

    for (( i=0; i<$num_monitors; i++ )); do
        local focused_workspace=$((next_workspace + i))

        # If the focused workspace exceeds the number of workspaces
        if [[ "$focused_workspace" -gt "$total_num_workspaces" ]]; then
            focused_workspace=$((focused_workspace - total_num_workspaces))
        fi

        hyprctl dispatch workspace "$focused_workspace"
    done
}
multi-monitor-workspaces::main "$1"
