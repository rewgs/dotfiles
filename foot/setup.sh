#!/bin/bash
#
# TODO:
# Symlinks the `.ini` file with the same name as the machine's $HOSTNAME env var to `foot.ini`.


setup-foot::main() {
    local this_file="$(realpath "$(dirname "${BASH_SOURCE}")")"

    local src="${this_file}/dots/${HOSTNAME}"
    local dst="${HOME}/.config/foot"

    echo "$src"

    if [[ ! -f "$src" ]]; then
        echo "Machine ${HOSTNAME} does not have a foot config! Exiting."
        exit
    fi

    if [[ ! -d "$dst" ]]; then
        mkdir -p "$dst"
    fi


    if [[ -f "$dst/foot.ini" ]] || [[ -L "$dst/foot.ini" ]]; then
        rm -f "$dst/foot.ini"
    fi

    if [[ ! -L "$dst/foot.ini" ]]; then
        ln -s "$src" "$dst/foot.ini"
    fi
}
setup-foot::main
