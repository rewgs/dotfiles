#!/bin/sh


# TODO:
# remove snap
# ssh key
# download dotfiles, checkout linux-minimal
# download this script


function install_oh_my_zsh () {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


function install_lazygit () {
    if [[ if -d $HOME/src ]]; then cd $HOME/src; fi
    git clone git@github.com:jesseduffield/lazygit.git
    cd lazygit
    go install
}


function install_tmux_from_source () {
    # install dependencies
    sudo apt install -y \
        bison \
        byacc \
        libevent-dev \

    if [[ if -d $HOME/src ]]; then cd $HOME/src; fi
    git clone git@github.com:tmux/tmux.git
    cd tmux
    sh autogen.sh
    ./configure && make
    sudo make clean install
}


function install_phpenv_build_prerequisites () {
    sudo apt install -y \
        libcurl4-gnutls-dev \
        libjpeg-dev \
        libonig-dev \
        libtidy-dev \
        libzip-dev \
}


function install_firefox_without_snap () {
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


function install_from_package_manager () {
    # `uname --all` is bound to include some reference to the distro name
    if [[ $(uname --all) == *"Ubuntu"* ]]; then
        sudo apt update && sudo apt upgrade -y
    
        sudo apt install \
            apache2 \
            bettercap \
            build-essential \
    		cmake \
            cmatrix \
            cowsay \
            curl \
    		docker \
            docker-compose \
            git \
    		hsetroot \
            htop \
    		libvirt-daemon \
    		llvm \
            lua \
    		make \
    		neofetch \
    		ncdu \
    		picom \
    		qemu-kvm \
    		shellcheck \
            software-properties-common \
    		tgt \
            tldr \
    		tmux \
    		tree \
    		vim \
            wget \
    		xorg \
    		zsh
    
        sudo apt update && sudo apt upgrade -y
    fi
}


function install_github_cli () {
	type -p curl >/dev/null || sudo apt install curl -y
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
}


function install_rust () {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	cargo install \
	    cargo-audi \
	    cargo-edit \
	    cargo-make \
	    cargo-tarpaulin \
	    cargo-watch
}


function install_nvm () {
    cd ~/src
    git clone git@github.com:nvm-sh/nvm.git
    ln -s ~/src/nvm/ ~/.nvm

    # from here, assumes that the following lines have been added to .bashrc, .zshrc, etc:
    # export NVM_DIR="$HOME/.nvm"
    # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    # should probably source .bashrc or .zshrc, and then...

    nvm install node    # installs absolute latest version
    nvm install --lts   # installs lts version
}



function install_npm_apps () {
	npm install gtop -g
}


function install_neovim_dependencies () {
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


function build_neovim_from_source () {
	cd ~/src/neovim
	git checkout stable
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
}


function install_packer_nvim () {
	git clone --depth 1 \
		https://github.com/wbthomason/packer.nvim \
		~/.local/share/nvim/site/pack/packer/start/packer.nvim
}


function install_tmux_package_manager () {
	cd ~/src
	git clone git@github.com:tmux-plugins/tpm.git
	ln -s ~/src/tpm ~/.tmux/plugins/tpm
}


function install_fira_code_nerd_font () {
    mkdir ~/.fonts
    cd ~/.fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
    unzip FiraCode.zip
    rm FiraCode.zip
    fc-cache -fv
}


function install_pyenv_build_dependencies () {
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


function main () {
}

main
