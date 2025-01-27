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
        starship::install::install-rust
    fi
    cargo::install
}
starship::install::main
