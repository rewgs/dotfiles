#!/bin/bash

function unix::main() {
    if [[ "$(uname)" == "Darwin" ]]; then
        source ./macOS/mac.sh
        return 0
    elif [[ "$(uname)" == "Linux" ]]; then
        source ./linux/linux.sh
        return 0
    else
        return 1
    fi
}
unix::main
