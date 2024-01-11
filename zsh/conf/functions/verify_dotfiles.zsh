# TODO:
# - Finish check_exist()
# - Add dotfiles for...
#   - git
#   - nvim
#   - tmux
#   - ...

set -e

verify_dotfiles::test_dotfiles_path () {
    echo "$DOTFILES"
}

verify_dotfiles::check_exist () {
    local files="$1"
    local exist=()

    for f in "${files[@]}"; do
        if [[ -f "$f" ]] || [[ -d "$f" ]]; then
            exist+=("$f")
        fi
    done

    echo "${exist[@]}"
}

verify_dotfiles::test_check_exist () {
    local dot_files=(
        "bashrc"
        "bash_profile"
    )
    exist=$(check_exist "${dot_files[@]}")
    for f in "${exist[@]}"; do
        echo "$f"
    done
}

verify_dotfiles::bash () {
    local dot_files=(
        "bashrc"
        "bash_profile"
    )

    for d in "${dot_files[@]}"; do
        local src="$DOTFILES/bash/$d"
        local dst="$HOME/.$d"

        if [[ -f "$dst" ]]; then
            rm "$dst"
        fi

        if [[ ! -L "$dst" ]]; then
            ln -s "$src" "$dst"
        fi
    done
}

verify_dotfiles::zsh () {
    local dot_files=(
        "zlogin"
        "zlogout"
        "zprofile"
        "zshenv"
        "zshrc"
    )

    for d in "${dot_files[@]}"; do
        local src="$DOTFILES/zsh/$d"
        local dst="$HOME/.$d"

        if [[ -f "$HOME/.$d" ]]; then
            rm "$HOME/.$d"
        fi

        if [[ ! -L "$HOME/.$d" ]]; then
            ln -s "$src" "$dst"
        fi
    done

    if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
        mkdir -p "$XDG_CONFIG_HOME"
    fi

    if [[ ! -L "$XDG_CONFIG_HOME/zsh" ]]; then
        ln -s "$DOTFILES/zsh/conf/" "$XDG_CONFIG_HOME/zsh"
    fi
}

# For $0 to equal the script/zsh function name, the "main" function 
# must also be the same as the script/zsh function name. Hence, instead of 
# `main()`, I have `verify_dotfiles()`.
verify_dotfiles () {
    # don't need this right?
    # cd "$ZFUNCS" || return

    # echo "Verifying bash symlinks..."
    # verify_dotfiles::bash

    # echo "Verifying zsh symlinks..."
    # verify_dotfiles::zsh
}
verify_dotfiles
