#!/bin/bash
#
# TODO:
# Symlinks the `.ini` file with the same name as the machine's $HOSTNAME env var to `fuzzel.ini`.


setup-fuzzel::main() {
    local this_file="$(realpath "$(dirname "${BASH_SOURCE}")")"

    local src="${this_file}/dots/${HOSTNAME}"
    local dst="${HOME}/.config/fuzzel"

    echo "$src"

    if [[ ! -f "$src" ]]; then
        echo "Machine ${HOSTNAME} does not have a fuzzel config! Exiting."
        exit
    fi

    if [[ ! -d "$dst" ]]; then
        mkdir -p "$dst"
    fi


    if [[ -f "$dst/fuzzel.ini" ]] || [[ -L "$dst/fuzzel.ini" ]]; then
        rm -f "$dst/fuzzel.ini"
    fi

    if [[ ! -L "$dst/fuzzel.ini" ]]; then
        ln -s "$src" "$dst/fuzzel.ini"
    fi
}
setup-fuzzel::main
