#!/usr/bin/env bash

basic_environment_setup () {
    dir="$1"

    cd "$dir" || return
    . distros.sh
    . packages/packages.sh
    # install_packages "$(get_distro)"
    install_packages "$dir"

    cd "$dir" || return
    . packages/misc.sh
    install_oh_my_zsh
    chsh -s "$(which zsh)" "$(whoami)"

    cd "$dir" || return
    . symlink_dotfiles.sh
    make_zsh_symlinks
    
    echo "All done! Restarting now..."
    reboot
}

main_tools_setup () {
    dir="$1"

    # tmux
    cd "$dir" || return
    . tmux.sh
    install_tmux_from_source
    install_tmux_package_manager

    # neovim
    cd "$dir" || return
    . neovim.sh
    install_neovim_dependencies
    build_neovim_from_source
    echo "Success: neovim installation" | cat >> "$log_file"
    install_packer_nvim
    echo "Success: packer.nvim installation" | cat >> "$log_file"
}

install_languages () {
    dir="$1"

    # nodejs
    cd "$dir" || return
    . nodejs.sh
    install_nvm_from_source
    echo "Success: nvm installation" | cat >> "$log_file"
    prep_for_nvm_nodejs_installs
    install_nodejs
    echo "Success: nodejs installation" | cat >> "$log_file"
    
    # phpenv
    cd "$dir" || return
    . phpenv.sh
    install_phpenv_build_prerequisites
    install_phpenv_from_source
    echo "Success: phpenv installation" | cat >> "$log_file"
    
    # pyenv
    cd "$dir" || return
    . pyenv.sh
    install_pyenv_build_dependencies
    install_pyenv_from_source
    echo "Success: pyenv installation" | cat >> "$log_file"
    prep_for_pyenv_python_installs
    install_python
    echo "Success: python installation" | cat >> "$log_file"

    cd "$dir" || return
    . rust.sh
    zsh -c install_rust
    zsh -c install_cargo_apps

    # not working for some reason
    . nodejs.sh
    zsh -c install_npm_apps
}

setup_gui () {
    dir="$1"

    cd "$dir" || return
    . gui.sh
    zsh -c install_fira_code_nerd_font
}


main () {
    this_repo=$( realpath "$(pwd)" )
    log_file="$this_repo/installation_log.txt"

    basic_environment_setup "$this_repo"
    # main_tools_setup "$this_repo"
    # install_languages "$this_repo"
    # setup_gui "$this_repo"
}
