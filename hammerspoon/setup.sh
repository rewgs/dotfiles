#!/bin/bash
#
# Sets up hammerspoon dotfiles.

function symlink-dotfiles() {
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


# Clones the Hammerspoon/Spoons repo to ~/src/Spoons (lean: no git submodule)
# and unzips the spoons we use into ~/src/Spoons/Spoons/. Hammerspoon finds them
# because dots/init.lua adds ~/src/Spoons/Spoons/?.spoon/init.lua to package.path.
function spoons() {
    local src="$HOME/src"

    local repo_url="https://github.com/Hammerspoon/Spoons"
    local repo_clone="$src/Spoons"

    # EmmyLua generates EmmyLua/lua-language-server annotations (autocomplete +
    # type hints in the editor) for Hammerspoon and every other spoon unzipped
    # here. dots/.luarc.json points lua_ls at its annotations/ dir.
    local spoons=(
        "WindowHalfsAndThirds"
        "EmmyLua"
    )

    function clone-repo() {
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

    function install-spoon() {
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

    clone-repo

    for spoon in "${spoons[@]}"; do
        install-spoon "$spoon"
    done
}

main() {
    local dots="$(realpath "$(dirname "$BASH_SOURCE")/dots")"

    spoons
    symlink-dotfiles "$dots"
}
main
