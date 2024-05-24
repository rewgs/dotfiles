install_rust () {
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    # source ~/.cargo/env
}


install_cargo_apps () {
    typeset -a cargo_apps
    cargo_apps=(
	    "cargo-audi"
	    "cargo-edit"
	    "cargo-make"
	    "cargo-tarpaulin"
	    "cargo-watch"

        # Great menu switcher for swaywm; commented out so that it's not installed on installs without sway
        # https://sr.ht/~tsdh/swayr/#swayr-installation
        # "swayr"
        "ytop"
    )

    for app in "${cargo_apps[@]}"; do
        cargo install "$app"
    done
}
