#!/usr/bin/bash


check_for_user_config_dir () {
    if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
        mkdir "$XDG_CONFIG_HOME"
    fi
}

symlink_bash () {
    local dot_files=(
        "bashrc"
        "bash_profile"
    )

    for d in "${dot_files[@]}"; do
        if [[ -f "$HOME/.$d" ]] || [[ -L "$HOME/.$d" ]]; then
            rm "$HOME/.$d"
        fi

        ln -s "$HOME/dotfiles/bash/$d" "$HOME/.$d"
    done
}

symlink_git () {
    local SRC="$HOME/dotfiles/git/"
    local DST="$XDG_CONFIG_HOME/git"

    check_for_user_config_dir

    if [[ -L "$DST" ]]; then rm "$DST"; fi
    if [[ ! -L "$DST" ]]; then ln -s "$SRC" "$DST"; fi
}



symlink_phpenv () {
    local SRC="$HOME/src/phpenv/"
    local DST="$HOME/.phpenv"
    if [[ -L "$DST" ]]; then ln -s "$SRC" "$DST"; fi
}

symlink_phpbuild () {
    local SRC="$HOME/src/php-build/"
    local PAR="$HOME/.phpenv/plugins"
    local DST="$PAR/php-build"

    if [[ ! -d "$PAR" ]]; then mkdir -p "$PAR"; fi
    if [[ -L "$DST" ]]; then ln -s "$SRC" "$DST"; fi
}

symlink_pyenv () {
    local SRC="$HOME/src/pyenv"
    local DST="$HOME/.pyenv"

    if [[ -L "$DST" ]]; then ln -s "$SRC" "$DST"; fi
}

symlink_sh () {
    if [[ -f "$HOME/.profile" ]] || [[ -L "$HOME/.profile" ]]; then
        rm "$HOME/.profile"
    fi

    ln -s "$HOME/dotfiles/sh/profile" "$HOME/.profile"
}


# symlink_zsh () {
#     local dot_files=(
#         "zlogin"
#         "zlogout"
#         "zprofile"
#         "zshenv"
#         "zshrc"
#     )

#     for d in "${dot_files[@]}"; do
#         if [[ -f "$HOME/.$d" ]] || [[ -L "$HOME/.$d" ]]; then
#             rm "$HOME/.$d"
#         fi

#         ln -s "$HOME/dotfiles/zsh/$d" "$HOME/.$d"
#     done

#     if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
#         mkdir -p "$XDG_CONFIG_HOME"
#     fi

#     ln -s "$HOME/dotfiles/zsh/conf/" "$XDG_CONFIG_HOME/zsh"
# }

make_all_symlinks () {
    symlink_bash
    symlink_git
    symlink_sh
    symlink_tmux
    # symlink_zsh
    symlink_pyenv
    symlink_phpenv
}
