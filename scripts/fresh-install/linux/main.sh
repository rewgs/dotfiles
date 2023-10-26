#!/usr/bin/env bash


function step_1 () {
    current=$(pwd)
    log_file="$current/installation_log.txt"

    cd "$current" || return
    source ./utils.sh
    # This isn't really working. Commenting out for now.
    # remove_snap

    # cd "$current" || return
    # echo "Running uninstall_apps_with_package_manager()" | cat >> "$log_file"
    # uninstall_apps_with_package_manager
    # echo "uninstall_apps_with_package_manager() finished!" | cat >> "$log_file"
    
    cd "$current" || return
    echo "Running install_apps_from_package_manager()" | cat >> "$log_file"
    install_apps_from_package_manager
    echo "install_apps_from_package_manager() finished!" | cat >> "$log_file"

    cd "$current" || return
    source ./misc_installs.sh
    echo "Running install_github_cli()" | cat >> "$log_file"
    install_github_cli
    echo "install_github_cli() finished!" | cat >> "$log_file"
    
    # tmux
    cd "$current" || return
    source ./tmux.sh
    echo "Installing tmux and tpm" | cat >> "$log_file"
    install_tmux_from_source
    install_tmux_package_manager
    echo "tmux and tpm installation finished!" | cat >> "$log_file"

    # for some reason, the following isn't running:
    # - neovim
    # - nodejs
    # - phpenv
    # - pyenv
    # ...but then install_oh_my_zsh runs. wtf?
    
    # neovim
    cd "$current" || return
    source ./neovim.sh
    echo "Installing neovim" | cat >> "$log_file"
    install_neovim_dependencies
    build_neovim_from_source
    install_packer_nvim
    echo "neovim installation finished!" | cat >> "$log_file"
    
    # nodejs
    cd "$current" || return
    source ./nodejs.sh
    echo "Installing nvm and nodejs" | cat >> "$log_file"
    install_nvm_from_source
    prep_for_nvm_nodejs_installs
    install_nodejs
    echo "nvm and nodejs installation finished!" | cat >> "$log_file"
    
    # phpenv
    cd "$current" || return
    source ./phpenv.sh
    echo "Installing phpenv" | cat >> "$log_file"
    install_phpenv_build_prerequisites
    install_phpenv_from_source
    echo "phpenv installation finished!" | cat >> "$log_file"
    
    # pyenv
    cd "$current" || return
    source ./pyenv.sh
    echo "Installing pyenv" | cat >> "$log_file"
    install_pyenv_build_dependencies
    install_pyenv_from_source
    echo "pyenv installation finished!" | cat >> "$log_file"
    # echo "Installing Python" | cat >> "$log_file"
    prep_for_pyenv_python_installs
    # python isn't being installed for some reason
    install_python
    # echo "Python installation finished!" | cat >> "$log_file"
    
    echo "Installing ohmyzsh..." | cat >> "$log_file"
    install_oh_my_zsh
    echo "ohmyzsh installation finished!" | cat >> "$log_file"
    echo "Changing shell to zsh..." | cat >> "$log_file"
    chsh -s "$(which zsh)" "$(whoami)"
    echo "Shell should now be zsh!" | cat >> "$log_file"
    echo "Symlinking to dotfiles..." | cat >> "$log_file"
    make_dotfiles_symlinks
    echo "Dotfiles symlinked!" | cat >> "$log_file"
    
    echo "All done! Restarting now..."
    reboot
}


function step_2 () {
    current=$(pwd)
    log_file="$current/installation_log.txt"

    cd "$current" || return
    source ./rust.sh
    zsh -c install_rust
    zsh -c install_cargo_apps

    # not working for some reason
    source ./nodejs.sh
    zsh -c install_npm_apps

    cd "$current" || return
    source ./gui.sh
    zsh -c install_fira_code_nerd_font
}


step_1
# step_2
