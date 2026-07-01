get_quickemu_vm() {
    local vm_name="$1"
    local path="$HOME/$vm_name.conf"
    if [ ! -f "$path" ]; then
        return 1
    fi
    echo "$path"
}

launch_quickemu_vm() {
    local vm
    vm="$(get_quickemu_vm "$1")"
    quickemu --vm "$vm"
}

alias vm="launch_quickemu_vm"
