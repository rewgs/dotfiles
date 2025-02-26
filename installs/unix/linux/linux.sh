#!/bin/bash

arch_based=(
    "EndeavourOS Linux"
)

# TODO:
# debian_based=()

# TODO:
# rhel_based=()

function linux::get-distro() {
    (lsb_release -ds || cat /etc/*release || uname -om) 2>/dev/null | head -n1
}

function linux::main() {
    local distro="$(linux::get-distro)"

    for d in "${arch_based[@]}"; do
        if [[ "$d" == "$distro" ]]; then
            if command -v pacman >/dev/null 2>&1; then
                source ./arch-based/arch.sh
                return 0
            fi
        fi
    done

    # for d in "${debian_based[@]}"; do
    #     if [[ "$d" == "$distro" ]]; then
    #         source ./debian-based/debian.sh
    #         return 0
    #     fi
    # done

    # for d in "${rhel_based[@]}"; do
    #     if [[ "$d" == "$distro" ]]; then
    #         source ./rhel-based/rhel.sh
    #         return 0
    #     fi
    # done

    return 1
}
linux::main
