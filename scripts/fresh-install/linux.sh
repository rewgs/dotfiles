#!/bin/sh


# TODO:
# - make ssh key, add to github account via `gh`
# - make it so that this can all run in one go, i.e. can continue past `exec $SHELL`
# - copy or symlink my tmux theme to ~/.tmux/plugins, and/or don't use the onedark package anymore?


# -u: If a variable does not exist, report the error and stop (e.g., unbound 
#   variable)
# -e: Terminate whenever an error occurs (e.g., command not found)
# -o pipefail: 	If a sub-command fails, the entire pipeline command fails, terminating the script (e.g., command not found)
# set -eu -o pipefail
set -eu # apparently `-o pipefail` isn't legal in POSIX shell


# -n: Non-interactive. Prevents sudo from prompting for a password. If one is 
#   required, sudo displays an error message and exits.
# true: Builtin command that returns a successful (zero) exit status.
sudo -n true


# test: Takes an expression as an argument, evaluates it as '0' (true) or '1' 
#   (false), and returns the result to the bash variable $?
# $?: A variable used to find the return value as the exit status of the last 
#   executed command.
# -eq 0: Equal to 0 -- in this case, the previous command (i.e. if `sudo -n 
#   true` returned 0).
# exit: Exits the shell with a status of N. If N is unspecified, it uses the 
#   exit code of the last executed command.
# 1: Value result is false and used here as an argument to the exit command to 
#   use as an exit code. If the exit code is false, the following message is 
#   printed to the terminal.
test $? -eq 0 || exit 1 "You should have sudo privilege to run this script."


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ functions                                                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

install_from_package_manager() {
    sleep 1
    sleep 1

    # `uname --all` is bound to include some reference to the distro name
    # FIXME: POSIX sh doesn't support globbing. Convert the following line to case statements.
    # if [ "$(uname --all)" = *"Ubuntu"* ] || [ "$(uname --all)" = *"Debian"* ]; then
    	echo "Checking for updates..."
        sudo apt-get update -qq
	if [ $? -eq 0 ]; then 
		echo "Upgrading packages..."
		sudo apt-get upgrade -qq -y
	fi
    
    	echo "Installing packages from package manager..."
        sudo apt-get install -y \
            apache2 \
            apt-transport-https \
            bettercap \
            btop \
            build-essential \
            cmake \
            cmatrix \
            cowsay \
            curl \
            docker \
            docker-compose \
            git \
            gnupg2 \
            golang-go \
            hsetroot \
            htop \
            libvirt-daemon \
            llvm \
            lua5.4 \
            lynx \
            make \
            neofetch \
            ncdu \
            picom \
            qemu-kvm \
            shellcheck \
            software-properties-common \
            tgt \
            tldr \
            tree \
            vim \
            wget \
            xorg \
            zsh \
	    > /dev/null 2> /dev/null	# for some reason, `&> /dev/null` isn't silent, but this is

    	echo "Checking for updates one more time..."
        sudo apt-get update -qq
	if [ $? -eq 0 ]; then 
		echo "Upgrading packages one more time..."
		sudo apt-get upgrade -qq -y
	fi
    # fi

    echo "Package manager basic installations complete! Moving on..."
    sleep 5
}


remove_snap() {
    # FIXME: POSIX sh doesn't support globbing. Convert the following line to case statements.
    # if [ "$(uname --all)" = *"Ubuntu"* ]; then
        # Returns list of snaps installed.
        # This is a very simple usage of awk, so the first item is `Name`, i.e. the 
        #   name of the first column. It will have to be skipped over when 
        #   iterating over these later.
        snap_list="$(snap list | awk '{print $1}')"

        # stop snap services
        sudo systemctl disable snapd.service
        sudo systemctl disable snapd.socket
        sudo systemctl disable snapd.seeded.service

        # In an effort to keep this POSIX compliant, arrays are avoided. Instead, 
        #   utilizes `tr` to simulate.
        # `tr ' ' '\n'` performs replaces spaces with new-lines, which are the 
        #   default delimiter for `read`.
        echo "$snap_list" | tr ' ' '\n' | while read item; do
            # As mentioned above, the first item `Name` is skipped.
            if "$item" != "Name"; then
                # can this take a -y flag?
                sudo snap remove "$item"
            fi
        done

        sudo rm -rf /var/cache/snapd

        # this -y flag might be positioned incorrectly
        sudo apt autoremove --purge -y snapd

        sudo rm -rf ~/snap
    # fi
}


build_tmux_from_source() {
    # for building new and updating
    cd "$HOME"/src/tmux
    git pull
    sh autogen.sh
    ./configure && make

    # apparently there's no 'clean' option?
    # sudo make clean install   
    sudo make install
}


install_tmux_from_source() {
    # install dependencies
    sudo apt install -y \
        bison \
        byacc \
        libevent-dev

    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/tmux/tmux.git

    build_tmux_from_source
}


install_tmux_package_manager() {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/tmux-plugins/tpm.git

    if [ ! -d "$HOME"/.tmux/plugins ]; then mkdir -p "$HOME"/.tmux/plugins; fi
	ln -s "$HOME"/src/tpm "$HOME"/.tmux/plugins/tpm
}


install_neovim_dependencies() {
	sudo apt-get install -y \
		ninja-build \
		gettext \
		libtool \
		libtool-bin \
		autoconf \
		automake \
		g++ \
		pkg-config \
		unzip \
		doxygen
}


build_neovim_from_source() {
    cd "$HOME"/src/neovim
	git checkout stable
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
}


install_neovim_from_source() {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/neovim/neovim.git

    build_neovim_from_source
}


install_packer_nvim() {
	git clone --depth 1 \
		https://github.com/wbthomason/packer.nvim \
		~/.local/share/nvim/site/pack/packer/start/packer.nvim
}


install_nvm_from_source() {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/nvm-sh/nvm.git
    ln -s "$HOME"/src/nvm/ "$HOME"/.nvm
}


install_phpenv_build_prerequisites() {
    sudo apt install -y \
        libcurl4-gnutls-dev \
        libjpeg-dev \
        libonig-dev \
        libtidy-dev \
        libzip-dev
}


install_phpenv_from_source() {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/phpenv/phpenv.git
    ln -s "$HOME"/src/phpenv/ "$HOME"/.phpenv
}


install_pyenv_build_dependencies() {
	sudo apt update; 
	sudo apt install -y \
		build-essential \
		libssl-dev \
		zlib1g-dev \
		libbz2-dev \
		libreadline-dev \
		libsqlite3-dev \
		curl \
		libncursesw5-dev \
		xz-utils \
		tk-dev \
		libxml2-dev \
		libxmlsec1-dev \
		libffi-dev \
		liblzma-dev
}


install_pyenv_from_source() {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/pyenv/pyenv.git
    ln -s "$HOME"/src/pyenv/ "$HOME"/.pyenv
}


install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # `< /dev/tty` forces that new shell to start reading input from the terminal. 
    #   Without this, the script would exit, returning to your calling script. I 
    #   don't want this to happen - I want more functions to run aftr this.
    exec zsh < /dev/tty
}


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


install_rust() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
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

# for servers or any other machine I'm not coding on but want to feel "at home"
basic_setup() {
    install_from_package_manager
    remove_snap

    # tmux
    install_tmux_from_source
    install_tmux_package_manager

    # neovim
    install_neovim_dependencies
    install_neovim_from_source
    install_packer_nvim

    # nodejs
    install_nvm_from_source

    # phpenv
    install_phpenv_build_prerequisites
    install_phpenv_from_source

    # pyenv
    install_pyenv_build_dependencies
    install_pyenv_from_source

    install_rust
    install_oh_my_zsh
}


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
    basic_setup
    personal_setup_cli
    # personal_setup_gui
}

main
