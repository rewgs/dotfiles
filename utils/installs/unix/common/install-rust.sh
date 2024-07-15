install_rust () {
    # old
    # curl https://sh.rustup.rs -sSf | sh -s -- -y

    # new
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
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
