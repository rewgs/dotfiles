#!/bin/bash
#
# Sets up hammerspoon dotfiles.

hammerspoon::symlink-dotfiles() {
    local src="$1"
    local dst="$HOME/.hammerspoon"

    if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then 
        rm -rf "$dst"
    fi

    if [[ ! -L "$dst" ]]; then 
        ln -s "$src" "$dst"
    fi

    return 0
}


# FIXME: This approach doesn't seem to really work, as there doesn't appear to 
# be a way to specify *where* Spoons live. Hammerspoon seems to only accept a 
# path relative to the module that's using a Spoon.
# Kinda hate that, as the only easy way to work with that is to keep the Spoons 
# repo in my dotfiles repo as a git submodule.
# That's just messy. Do not want.
hammerspoon::spoons() {
    local src="$HOME/src"

    local repo_url="https://github.com/Hammerspoon/Spoons"
    local repo_clone="$src/Spoons"

    local spoons=(
        "WindowHalfsAndThirds"
    )

    spoons::clone-repo() {
        if [[ ! -d "$src" ]]; then 
            mkdir -p "$src"
        fi

        # if [[ -d "$dst" ]] || [[ -L "$dst" ]]; then 
        #     rm -rf "$dst"
        # fi

        if [[ ! -d "$repo_clone" ]]; then 
            git clone "$repo_url" "$repo_clone"
        fi

        return 0
    }

    install-spoon() {
        local spoon="$1"
        local spoons_dir="$repo_clone/Spoons"
        for file in "$spoons_dir"/*; do
            if [[ -f "$file" ]]; then
                local zipped_spoon="$(basename "$file")"
                if [[ "$zipped_spoon" == "$spoon.spoon.zip" ]]; then
                    local spoon_name_no_zip="${zipped_spoon%.zip}"

                    # remove leading whitespace characters just in case
                    local trimmed_leading_whitespace="${spoon_name_no_zip#"${spoon_name_no_zip%%[![:space:]]*}"}"

                    # remove trailing whitespace characters just in case
                    local spoon_name="${trimmed_leading_whitespace%"${trimmed_leading_whitespace##*[![:space:]]}"}"

                    local dst="$spoons_dir/$spoon_name"

                    # unzips Spoon
                    if [[ ! -d "$dst" ]]; then
                        echo "Unzipping $file to $spoons_dir..."
                        unzip -o "$file" -d "$spoons_dir"
                    fi

                    # Checks that the unzip worked correctly
                    if [[ ! -d "$dst" ]]; then
                        echo "Something went wrong unzipping $file!"
                        return 1
                    fi

                    # TODO: Need to somehow *install* the spoon, but that requires Hammerspoon to see the Spoons repo...
                    # See "FIXME" above for explanation.
                fi
            fi
        done
    }

    spoons::clone-repo

    for spoon in "${spoons[@]}"; do
        install-spoon "$spoon"
    done
}

hammerspoon::main() {
    local dots="$(realpath "$(dirname "$BASH_SOURCE")/dots")"

    hammerspoon::spoons
    hammerspoon::symlink-dotfiles "$dots"
}
hammerspoon::main
