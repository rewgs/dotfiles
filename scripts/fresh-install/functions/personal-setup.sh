#!/usr/bin/env zsh


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ functions                                                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

prep_for_nvm_nodejs_installs() {
    echo 'export NVM_DIR=\\"\$([ -z \"\${XDG_CONFIG_HOME-}\" ] && printf %s \"\${HOME}/.nvm\" || printf %s \"\${XDG_CONFIG_HOME}/nvm\")\"' >> "$HOME"/.zshrc
    echo '[ -s \"\$NVM_DIR/nvm.sh\\" ] && \\. \"\$NVM_DIR/nvm.sh\"' >> "$HOME"/.zshrc
}


install_nodejs() {
    # This is what is added to .zshrc in order to run nvm. It's in there, so I shouldn't need to 
    #   add this, but for whatever reason, `nvm` isn't found when running this function unless this 
    #   is included, even though .zshrc has been sourced. Doesn't make any sense, but this works, 
    #   so it's a problem for another day.
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # installs absolute latest version
    nvm install node    

    # installs lts version
    nvm install --lts   
    nvm use --lts
}


prep_for_pyenv_python_installs() {
    echo 'export PYENV_ROOT=""$HOME"/.pyenv"' >> "$HOME"/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> "$HOME"/.zshrc
    echo 'eval "$(pyenv init -)"' >> "$HOME"/.zshrc
}


install_python() {
    # gets the system version (minus the word "Python"), then installs that 
    #   version with pyenv and sets it to "global."
    system_python_version=$(python3 --version)

    # `s/.* //` deletes from the beginning to the first space
    python_version=$(echo "$system_python_version" | sed 's/.* //')

    pyenv install "$python_version"
    pyenv global "$python_version"
}


download_dotfiles() {
    cd "$HOME"
    git clone https://github.com/rewgs/dotfiles.git
}


# TODO: make sure this works on macOS!
make_dotfiles_symlinks() {
    # ╔════════════════════════════════════════════════════════════════════════════╗
    # ║ make directories                                                           ║
    # ╚════════════════════════════════════════════════════════════════════════════╝
    
    if [ ! -d "$HOME"/.config ]; then
        mkdir "$HOME"/.config
    fi
    
    if [ ! -d "$HOME"/dotfile_backups/bash ]; then
        mkdir -p "$HOME"/dotfile_backups/bash
    fi
    
    if [ ! -d "$HOME"/dotfile_backups/nvim ]; then
        mkdir -p "$HOME"/dotfile_backups/nvim
    fi
    
    if [ ! -d "$HOME"/dotfile_backups/sh ]; then
        mkdir -p "$HOME"/dotfile_backups/sh
    fi
    
    if [ ! -d "$HOME"/dotfile_backups/tmux ]; then
        mkdir -p "$HOME"/dotfile_backups/tmux
    fi
    
    if [ ! -d "$HOME"/dotfile_backups/zsh ]; then
        mkdir -p "$HOME"/dotfile_backups/zsh
    fi
    
    # ╔════════════════════════════════════════════════════════════════════════════╗
    # ║ create symlinks (and backup if target already present)                     ║
    # ╚════════════════════════════════════════════════════════════════════════════╝
    
    # bash
    if [ -f "$HOME"/.bashrc ]; then
        mv "$HOME"/.bashrc "$HOME"/dotfile_backups/bashrc
        ln -s "$HOME"/dotfiles/bash/bashrc "$HOME"/.bashrc
    elif [ -h "$HOME"/.bashrc ]; then
        rm "$HOME"/.bashrc
        ln -s "$HOME"/dotfiles/bash/bashrc "$HOME"/.bashrc
    else
        ln -s "$HOME"/dotfiles/bash/bashrc "$HOME"/.bashrc
    fi
    
    if [ -f "$HOME"/.bash_profile ]; then
        mv "$HOME"/.bash_profile "$HOME"/dotfile_backups/bash_profile
        ln -s "$HOME"/dotfiles/bash/bash_profile "$HOME"/.bash_profile
    elif [ -h "$HOME"/.bash_profile ]; then
        rm "$HOME"/.bash_profile
        ln -s "$HOME"/dotfiles/bash/bash_profile "$HOME"/.bash_profile
    else
        ln -s "$HOME"/dotfiles/bash/bash_profile "$HOME"/.bash_profile
    fi
    

    # nvim
    if [ -d "$HOME"/.config/nvim ]; then
        mv "$HOME"/.config/nvim "$HOME"/dotfile_backups/nvim
        ln -s "$HOME"/dotfiles/nvim/ "$HOME"/.config/nvim
    elif [ -h "$HOME"/.config/nvim ]; then
        rm "$HOME"/.config/nvim/
        ln -s "$HOME"/dotfiles/nvim/ "$HOME"/.config/nvim
    else
        ln -s "$HOME"/dotfiles/nvim/ "$HOME"/.config/nvim
    fi
    

    # sh
    if [ -f "$HOME"/.profile ]; then
        mv "$HOME"/.profile "$HOME"/dotfile_backups/sh/
        ln -s "$HOME"/dotfiles/sh/profile "$HOME"/.profile
    elif [ -h "$HOME"/.profile ]; then
        rm "$HOME"/.profile
        ln -s "$HOME"/dotfiles/sh/profile "$HOME"/.profile
    else
        ln -s "$HOME"/dotfiles/sh/profile "$HOME"/.profile
    fi
    
    # tmux
    if [ -f "$HOME"/.tmux.conf ]; then
        mv "$HOME"/.tmux.conf "$HOME"/dotfile_backups/tmux/
        ln -s "$HOME"/dotfiles/tmux/tmux.conf "$HOME"/.tmux.conf
    elif [ -h "$HOME"/.tmux.conf ]; then
        rm "$HOME"/.tmux.conf
        ln -s "$HOME"/dotfiles/tmux/tmux.conf "$HOME"/.tmux.conf
    else
        ln -s "$HOME"/dotfiles/tmux/tmux.conf "$HOME"/.tmux.conf
    fi
     
    if [ ! -d "$HOME"/src/tpm ]; then
        ln -s "$HOME"/src/tpm/ "$HOME"/.tmux/plugins/tpm
    elif [ -h "$HOME"/.tmux/plugins/tpm ]; then
        rm "$HOME"/.tmux/plugins/tpm
        ln -s "$HOME"/src/tpm/ "$HOME"/.tmux/plugins/tpm
    else
        ln -s "$HOME"/src/tpm/ "$HOME"/.tmux/plugins/tpm
    fi
    
    
    # zsh
    if [ -f "$HOME"/.zshenv ]; then
        mv "$HOME"/.zshenv "$HOME"/dotfile_backups/zsh/
        ln -s "$HOME"/dotfiles/zsh/zshenv "$HOME"/.zshenv
    elif [ -h "$HOME"/.zshenv ]; then
        rm "$HOME"/.zshenv
        ln -s "$HOME"/dotfiles/zsh/zshenv "$HOME"/.zshenv
    else
        ln -s "$HOME"/dotfiles/zsh/zshenv "$HOME"/.zshenv
    fi
    
    if [ -f "$HOME"/.zprofile ]; then
        mv "$HOME"/.zprofile "$HOME"/dotfile_backups/zsh/
        ln -s "$HOME"/dotfiles/zsh/zprofile "$HOME"/.zprofile
    elif [ -h "$HOME"/.zprofile ]; then
        rm "$HOME"/.zprofile
        ln -s "$HOME"/dotfiles/zsh/zprofile "$HOME"/.zprofile
    else
        ln -s "$HOME"/dotfiles/zsh/zprofile "$HOME"/.zprofile
    fi
    
    if [ -f "$HOME"/.zshrc ]; then
        mv "$HOME"/.zshrc "$HOME"/dotfile_backups/zsh/
        ln -s "$HOME"/dotfiles/zsh/zshrc "$HOME"/.zshrc
    elif [ -h "$HOME"/.zshrc ]; then
        rm "$HOME"/.zshrc
        ln -s "$HOME"/dotfiles/zsh/zshrc "$HOME"/.zshrc
    else
        ln -s "$HOME"/dotfiles/zsh/zshrc "$HOME"/.zshrc
    fi
    
    if [ -f "$HOME"/.zlogin ]; then
        mv "$HOME"/.zlogin "$HOME"/dotfile_backups/zsh/
        ln -s "$HOME"/dotfiles/zsh/zlogin "$HOME"/.zlogin
    elif [ -h "$HOME"/.zlogin ]; then
        rm "$HOME"/.zlogin
        ln -s "$HOME"/dotfiles/zsh/zlogin "$HOME"/.zlogin
    else
        ln -s "$HOME"/dotfiles/zsh/zlogin "$HOME"/.zlogin
    fi
    
    if [ -f "$HOME"/.zlogout ]; then
        mv "$HOME"/.zlogout "$HOME"/dotfile_backups/zsh/
        ln -s "$HOME"/dotfiles/zsh/zlogout "$HOME"/.zlogout
    elif [ -h "$HOME"/.zlogout ]; then
        rm "$HOME"/.zlogout
        ln -s "$HOME"/dotfiles/zsh/zlogout "$HOME"/.zlogout
    else
        ln -s "$HOME"/dotfiles/zsh/zlogout "$HOME"/.zlogout
    fi
}


install_lazygit_from_source() {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/jesseduffield/lazygit.git
    cd "$HOME"/src/lazygit
    go install
}


install_npm_apps() {
	npm install gtop -g
}


install_rust_apps() {
	cargo install \
	    cargo-audi \
	    cargo-edit \
	    cargo-make \
	    cargo-tarpaulin \
	    cargo-watch \
        ytop
}


install_github_cli() {
    # add repository
	type -p curl >/dev/null || sudo apt install curl -y
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \

	sudo apt update && sudo apt install gh -y
}


install_firefox_without_snap() {
    # assumes that snap has already been removed and `sudo snap remove firefox` run

    # depends on software-properties-common package (installed in `install_from_package_manager()`
    sudo add-apt-repository ppa:mozillateam/ppa

    # alters the Firefox package priority to ensure the PPA/deb/apt version is preferred
    echo '
    Package: *
    Pin: release o=LP-PPA-mozillateam
    Pin-Priority: 1001
    ' | sudo tee /etc/apt/preferences.d/mozilla-firefox

    # ensures future Firefox upgrades are installed
    echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

    sudo apt update && sudo apt install firefox
}


install_fira_code_nerd_font() {
    mkdir ~/.fonts
    cd ~/.fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
    unzip FiraCode.zip
    rm FiraCode.zip
    fc-cache -fv
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ macros                                                                     ║
# ║                                                                            ║
# ║ These are comprised of the individual functions above.                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

personal_setup_cli() {
    make_dotfiles_symlinks
    install_nodejs
    install_python
    # install_lazygit_from_source   # not working now so not running
    install_npm_apps
    install_rust_apps
    install_github_cli
}


personal_setup_gui() {
    install_firefox_without_snap
    install_fira_code_nerd_font
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ main                                                                       ║
# ║                                                                            ║
# ║ Comprised of one or more macros; separated by machine usage.               ║
# ║ These don't overlap at all -- instead they cascade/build upon each other.  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

main() {
    personal_setup_cli
    # personal_setup_gui
}

main
