#!/usr/bin/bash
#
# This is the primary install script for fresh Linux installs.

# TODO:
# linux::main() {
# }

# =============================================================================
# OLD
# =============================================================================

# THIS_DIR="$(dirname "$(readlink -f "$0")" )"
# 
# basic_environment_setup () {
#     cd "$THIS_DIR" || return
#     . "$THIS_DIR/packages/packages.sh"
#     install_packages "$THIS_DIR"
# 
#     cd "$THIS_DIR" || return
#     . packages/misc.sh
#     install_oh_my_zsh
#     chsh -s "$(which zsh)" "$(whoami)"
# 
#     cd "$THIS_DIR" || return
#     . symlink_dotfiles.sh
#     make_zsh_symlinks
#     
#     echo "All done! Restarting now..."
#     reboot
# }
# 
# main_tools_setup () {
#     dir="$1"
# 
#     # tmux
#     cd "$THIS_DIR" || return
#     . tmux.sh
#     install_tmux_from_source
#     install_tmux_package_manager
# 
#     # neovim
#     cd "$THIS_DIR" || return
#     . neovim.sh
#     install_neovim_dependencies
#     build_neovim_from_source
#     echo "Success: neovim installation" | cat >> "$log_file"
#     install_packer_nvim
#     echo "Success: packer.nvim installation" | cat >> "$log_file"
# }
# 
# install_languages () {
#     dir="$1"
# 
#     # nodejs
#     cd "$THIS_DIR" || return
#     . nodejs.sh
#     install_nvm_from_source
#     echo "Success: nvm installation" | cat >> "$log_file"
#     prep_for_nvm_nodejs_installs
#     install_nodejs
#     echo "Success: nodejs installation" | cat >> "$log_file"
#     
#     # phpenv
#     cd "$THIS_DIR" || return
#     . phpenv.sh
#     install_phpenv_build_prerequisites
#     install_phpenv_from_source
#     echo "Success: phpenv installation" | cat >> "$log_file"
#     
#     # pyenv
#     cd "$THIS_DIR" || return
#     . pyenv.sh
#     install_pyenv_build_dependencies
#     install_pyenv_from_source
#     echo "Success: pyenv installation" | cat >> "$log_file"
#     prep_for_pyenv_python_installs
#     install_python
#     echo "Success: python installation" | cat >> "$log_file"
# 
#     cd "$THIS_DIR" || return
#     . rust.sh
#     zsh -c install_rust
#     zsh -c install_cargo_apps
# 
#     # not working for some reason
#     . nodejs.sh
#     zsh -c install_npm_apps
# }
# 
# setup_gui () {
#     dir="$1"
# 
#     cd "$THIS_DIR" || return
#     . gui.sh
#     zsh -c install_fira_code_nerd_font
# }
# 
# 
# main () {
#     # log_file="$THIS_DIR/installation_log.txt"
# 
#     basic_environment_setup
#     # main_tools_setup "$THIS_DIR"
#     # install_languages "$THIS_DIR"
#     # setup_gui "$THIS_DIR"
# }
