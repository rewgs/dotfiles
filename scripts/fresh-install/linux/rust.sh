function install_rust () {
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    # source ~/.cargo/env
}


function install_cargo_apps () {
    typeset -a cargo_apps
    cargo_apps=(
	    "cargo-audi"
	    "cargo-edit"
	    "cargo-make"
	    "cargo-tarpaulin"
	    "cargo-watch"
        "ytop"
    )

    for app in "${cargo_apps[@]}"; do
        cargo install "$app"
    done
}
