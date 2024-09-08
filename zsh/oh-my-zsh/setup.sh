#!/bin/bash
#
# Symlinks directories within `custom` to `~/.oh-my-zsh/custom/`


zsh-custom-plugins::install() {
    local src
    local zsh_custom_plugins


    # Verifying directories
    src="$HOME/src"
    if [[ ! -d "$src" ]]; then mkdir -p "$src"; fi

    zsh_custom_plugins="$HOME/.oh-my-zsh/custom/plugins"
    if [[ ! -d "$zsh_custom_plugins" ]]; then mkdir -p "$zsh_custom_plugins"; fi


    # This simply loops through all arguments, so be sure that only the expanded 
    # array is passed to this function in `main()`.
    for plugin in "$@"; do
        name="$(basename "$plugin")"

        local clone_dst="$src/$name"
        local link_dst="$zsh_custom_plugins/$name"

        # Clones all repos in `$custom_plugins` to `$src`.
        if [[ ! -d "$clone_dst" ]]; then 
            git clone "$plugin" "$clone_dst"
        # else
        #     echo "$name has already been cloned."
        fi

        # Symlinks all repos in `custom_plugins` to:
        # "$HOME/.oh-my-zsh/custom/plugins"
        if [[ ! -L "$link_dst" ]]; then 
            ln -s "$clone_dst" "$link_dst"

            if [[ -L "$link_dst" ]]; then 
                echo "Symlinked $clone_dst to $link_dst!"
            fi
        fi
    done

    return 0
}


zsh-custom-plugins::main() {
    local custom_plugins=(
        # Lazy loads nvm
        "https://github.com/lukechilds/zsh-nvm"

        # Drastically improves startup time by caching `eval` expressions.
        # This is for pyenv, phpenv, rbenv, etc.
        "https://github.com/mroth/evalcache"
    )

    zsh-custom-plugins::install "${custom_plugins[@]}"
}
zsh-custom-plugins::main
