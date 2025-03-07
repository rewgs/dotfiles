get-quickemu-vm () {
    local vm_name="$1"
    local path="$HOME/$vm_name.conf"
    if [[ ! -f "$path" ]]; then
        return 1
    fi
    echo "$path"
}

launch-quickemu-vm () {
    local vm="$(get-quickemu-vm "$1")"
    quickemu --vm "$vm"
}

# TODO: tab to auto-complete available VMs
alias vm=launch-quickemu-vm "$1"
