#!/bin/bash
#
# Install Starship via `cargo`. If Rust is not installed, installs that first.

starship::install::install-rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

starship::install() {
    cargo install starship --locked
}

starship::install::main() {
    if ! command -v cargo 2>&1 >/dev/null; then
        # TODO: Prompt user for if they want to do this. On Arch, I like to install rustup via pacman.
        starship::install::install-rust
    fi
    cargo::install
}
starship::install::main
