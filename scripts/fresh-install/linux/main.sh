#!/usr/bin/env bash

function step_1 () {
    this_repo=$(pwd)
    # log_file="$this_repo/installation_log.txt"
    
    cd "$this_repo" || return
    source ./distros.sh
    distro=$(get_distro)

    cd "$this_repo" || return
    source ./packages/packages.sh
    install_packages "$distro"

    # cd "$this_repo" || return
    # source ./packages/misc.sh
    # install_oh_my_zsh
    # chsh -s "$(which zsh)" "$(whoami)"

    # cd "$this_repo" || return
    # source ./symlink_dotfiles.sh
    # make_zsh_symlinks
    
    # echo "All done! Restarting now..."
    # reboot

    # tmux
    # cd "$this_repo" || return
    # source ./tmux.sh
    # install_tmux_from_source
    # install_tmux_package_manager

    # neovim
    # cd "$this_repo" || return
    # source ./neovim.sh
    # install_neovim_dependencies
    # build_neovim_from_source
    # echo "Success: neovim installation" | cat >> "$log_file"
    # install_packer_nvim
    # echo "Success: packer.nvim installation" | cat >> "$log_file"
    
    # nodejs
    # cd "$this_repo" || return
    # source ./nodejs.sh
    # install_nvm_from_source
    # echo "Success: nvm installation" | cat >> "$log_file"
    # prep_for_nvm_nodejs_installs
    # install_nodejs
    # echo "Success: nodejs installation" | cat >> "$log_file"
    
    # phpenv
    # cd "$this_repo" || return
    # source ./phpenv.sh
    # install_phpenv_build_prerequisites
    # install_phpenv_from_source
    # echo "Success: phpenv installation" | cat >> "$log_file"
    
    # pyenv
    # cd "$this_repo" || return
    # source ./pyenv.sh
    # install_pyenv_build_dependencies
    # install_pyenv_from_source
    # echo "Success: pyenv installation" | cat >> "$log_file"
    # prep_for_pyenv_python_installs
    # install_python
    # echo "Success: python installation" | cat >> "$log_file"
    
}


function step_2 () {
    this_repo=$(pwd)
    log_file="$this_repo/installation_log.txt"

    cd "$this_repo" || return
    source ./rust.sh
    zsh -c install_rust
    zsh -c install_cargo_apps

    # not working for some reason
    source ./nodejs.sh
    zsh -c install_npm_apps

    cd "$this_repo" || return
    source ./gui.sh
    zsh -c install_fira_code_nerd_font
}


step_1
# step_2
