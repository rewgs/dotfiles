make_bash_symlinks () {
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

make_neovim_symlinks () {
    if [ ! -d "$HOME/.config" ]; then
        mkdir "$HOME/.config"
    fi

    if [ -d "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]; then
        rm "$HOME/.config/nvim"
    fi

    ln -s "$HOME/dotfiles/nvim/" "$HOME/.config/nvim"
}

make_sh_symlinks () {
    if [ -f "$HOME/.profile" ] || [ -L "$HOME/.profile" ]; then
        rm "$HOME/.profile"
    fi

    ln -s "$HOME/dotfiles/sh/profile" "$HOME/.profile"
}

make_tmux_symlinks () {
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

make_zsh_symlinks () {
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
    ln -s "$HOME/dotfiles/zsh/conf" "$HOME/.config/zsh/conf"
}

make_all_symlinks () {
    make_bash_symlinks
    make_neovim_symlinks
    make_sh_symlinks
    make_tmux_symlinks
    make_zsh_symlinks
}
