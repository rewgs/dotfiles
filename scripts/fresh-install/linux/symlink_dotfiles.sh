#!/usr/bin/bash

symlink_bash () {
    declare -r -a dot_files
    dot_files=(
        "bashrc"
        "bash_profile"
    )

    for d in "${dot_files[@]}"; do
        if [ -f "$HOME/.$d" ] || [ -L "$HOME/.$d" ]; then
            rm "$HOME/.$d"
        fi

        ln -s "$HOME/dotfiles/bash/$d" "$HOME/.$d"
    done
}

symlink_neovim () {
    if [ ! -d "$HOME/.config" ]; then
        mkdir "$HOME/.config"
    fi

    if [ -d "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]; then
        rm "$HOME/.config/nvim"
    fi

    ln -s "$HOME/dotfiles/nvim/" "$HOME/.config/nvim"
}

symlink_phpenv () {
    src="$HOME/src/phpenv/"
    dst="$HOME/.phpenv"

    if [[ -L "$dst" ]]; then ln -s "$src" "$dst"; fi
}

symlink_phpbuild () {
    src="$HOME/src/php-build/"
    par="$HOME/.phpenv/plugins"
    dst="$par/php-build"

    if [[ ! -d "$par" ]]; then mkdir -p "$par"; fi
    if [[ -L "$dst" ]]; then ln -s "$src" "$dst"; fi
}

symlink_pyenv () {
    src="$HOME/src/pyenv"
    dst="$HOME/.pyenv"

    if [[ -L "$dst" ]]; then ln -s "$src" "$dst"; fi
}

symlink_sh () {
    if [ -f "$HOME/.profile" ] || [ -L "$HOME/.profile" ]; then
        rm "$HOME/.profile"
    fi

    ln -s "$HOME/dotfiles/sh/profile" "$HOME/.profile"
}

symlink_tmux () {
    # tmux
    if [[ -f "$HOME/.tmux.conf" ]] || [[ -L "$HOME/.tmux.conf" ]]; then
        rm "$HOME/.tmux.conf"
    fi
    ln -s "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"

    # tpm
    if [[ ! -d "$HOME/.tmux/plugins" ]]; then
        mkdir "$HOME/.tmux/plugins"
    fi
    if [[ -d "$HOME/.tmux/plugins/tpm" ]] || [[ -L "$HOME"/.tmux/plugins/tpm ]]; then
        rm "$HOME"/.tmux/plugins/tpm
    fi
    ln -s "$HOME/src/tpm/" "$HOME/.tmux/plugins/tpm"
}

symlink_zsh () {
    declare -a dot_files
    dot_files=(
        "zlogin"
        "zlogout"
        "zprofile"
        "zshenv"
        "zshrc"
    )
    for d in "${dot_files[@]}"; do
        if [ -f "$HOME/.$d" ] || [ -L "$HOME/.$d" ]; then
            rm "$HOME/.$d"
        fi
        ln -s "$HOME/dotfiles/zsh/$d" "$HOME/.$d"
    done

    if [ ! -d "$HOME/.config" ]; then
        mkdir -p "$HOME/.config/zsh"
    fi
    ln -s "$HOME/dotfiles/zsh/conf/" "$HOME/.config/zsh"
}

make_all_symlinks () {
    symlink_bash
    symlink_neovim
    symlink_sh
    symlink_tmux
    symlink_zsh
    symlink_pyenv
    symlink_phpenv
}
