#!/bin/bash

install-homebrew::main() { 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}
install-homebrew::main
