#!/bin/bash
#
# Symlinks the files in `dots` to `~`.

setup-sh::main() {
    dots="$(dirname "$(realpath "${BASH_SOURCE}")")/dots"
    for file in "${dots}"/*; do
        src="$(realpath "${file}")"
        name="$(basename "${src}")"
        dst="${HOME}/.${name}"

        if [[ -f "${dst}" ]] || [[ -L "${dst}" ]]; then
            rm "${dst}"
        fi

        if [[ ! -L "${dst}" ]]; then
            ln -s "${src}" "${dst}"
            echo "Symlinked:"
            echo -e "\t${src}"
            echo -e "\tto"
            echo -e "\t${dst}\n"
        fi
    done
}
setup-sh::main
