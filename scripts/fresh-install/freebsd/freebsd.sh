#!/usr/bin/env csh


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ functions                                                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

function install_from_package_manager() {
    echo "Checking for updates..."
    sudo pkg update

    # `$?` is used to find the return value of the last executed command
	if [ $? -eq 0 ]; then 
		echo "Upgrading packages..."
		sudo pkg upgrade
	fi

    typeset -a apps 
    apps=(
        "apache2"
        "apt-transport-https"
        "automake"
        "bettercap"
        "bpytop"
        "btop"
        "build-essential"
        "cbonsai"
        "cmake"
        "cmatrix"
        "cowsay"
        "curl"
        "docker"
        "docker-compose"
        "git"
        "glances"
        "gnupg2"
        "golang-go"
        "hsetroot"
        "htop"
        "libvirt-daemon"
        "llvm"
        "lua5.4"
        "lynx"
        "make"
        "neofetch"
        "ncdu"
        "picom"
        "qemu-kvm"
        "shellcheck"
        "software-properties-common"
        "tgt"
        "thefuck"
        "tldr"
        "tree"
        "vim"
        "wget"
        "xorg"
        "zsh"
    )
    
    echo "Installing packages from package manager..."
    for a in ${apps[@]}; do
        sudo apt-get install -y "$a"
	    # > /dev/null 2> /dev/null # for some reason, `&> /dev/null` isn't silent, but this is
    done

    echo "Package manager basic installations complete! Moving on..."
    sleep 3
}


# -----------------------------------------------------------------------------
# FIXME: All that follows is for Linux; needs to be adapted to FreeBSD
# -----------------------------------------------------------------------------

function build_tmux_from_source() {
    # for building new and updating
    cd "$HOME"/src/tmux
    git pull
    sh autogen.sh
    ./configure && make

    # apparently there's no 'clean' option?
    # sudo make clean install   
    sudo make install
}


function install_tmux_from_source() {
    # install dependencies
    sudo apt install -y \
        bison \
        byacc \
        libevent-dev

    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/tmux/tmux.git

    build_tmux_from_source
}


function install_tmux_package_manager() {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/tmux-plugins/tpm.git

    if [ ! -d "$HOME"/.tmux/plugins ]; then mkdir -p "$HOME"/.tmux/plugins; fi
	ln -s "$HOME"/src/tpm "$HOME"/.tmux/plugins/tpm
}


function install_neovim_dependencies() {
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


function update_neovim_from_source() {
	cd "$HOME"/src/neovim
	git checkout stable
	git pull
	sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make clean install
}


function install_neovim_from_source() {
    install_neovim_dependencies

    if [ ! -d ~/src ]; then mkdir ~/src; fi
    cd ~/src
    git clone --depth 1 https://github.com/neovim/neovim.git --branch stable
    cd ~/src/neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
}


function install_packer_nvim() {
	git clone --depth 1 \
		https://github.com/wbthomason/packer.nvim \
		~/.local/share/nvim/site/pack/packer/start/packer.nvim
}


function install_nvm_from_source() {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/nvm-sh/nvm.git
    ln -s "$HOME"/src/nvm/ "$HOME"/.nvm
}


function install_phpenv_build_prerequisites() {
    sudo apt install -y \
        apache2-dev \
        libcurl4-gnutls-dev \
        libjpeg-dev \
        libonig-dev \
        libtidy-dev \
        libzip-dev \
        re2c
}


function install_phpenv_from_source() {
    # install phpenv
    if [ ! -d ~/src ]; then mkdir ~/src; fi
    cd ~/src
    git clone --depth 1 https://github.com/phpenv/phpenv.git
    ln -s ~/src/phpenv/ ~/.phpenv

    # install php-build -- required to use the `phpenv install` command, which is 99% of what I do with phpenv
    cd ~/src
    git clone --depth 1 https://github.com/php-build/php-build.git
    if [ ! -d ~/.phpenv/plugins ]; then mkdir -p ~/.phpenv/plugins; fi
    ln -s ~/src/php-build/ ~/.phpenv/plugins/php-build

    # required for phpenv to see php-build
    # should also be run after each new version of php is installed
    phpenv rehash
}


function install_pyenv_build_dependencies() {
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


function install_pyenv_from_source() {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/pyenv/pyenv.git
    ln -s "$HOME"/src/pyenv/ "$HOME"/.pyenv
}




function prep_for_nvm_nodejs_installs() {
    echo 'export NVM_DIR=\\"\$([ -z \"\${XDG_CONFIG_HOME-}\" ] && printf %s \"\${HOME}/.nvm\" || printf %s \"\${XDG_CONFIG_HOME}/nvm\")\"' >> "$HOME"/.bashrc
    echo '[ -s \"\$NVM_DIR/nvm.sh\\" ] && \\. \"\$NVM_DIR/nvm.sh\"' >> "$HOME"/.bashrc

    echo 'export NVM_DIR=\\"\$([ -z \"\${XDG_CONFIG_HOME-}\" ] && printf %s \"\${HOME}/.nvm\" || printf %s \"\${XDG_CONFIG_HOME}/nvm\")\"' >> "$HOME"/.zshrc
    echo '[ -s \"\$NVM_DIR/nvm.sh\\" ] && \\. \"\$NVM_DIR/nvm.sh\"' >> "$HOME"/.zshrc
}


function install_nodejs() {
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
    # nvm use --lts
}


function prep_for_pyenv_python_installs() {
    # bash
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc

    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
    echo 'eval "$(pyenv init -)"' >> ~/.profile

    # zsh
    echo 'export PYENV_ROOT=""$HOME"/.pyenv"' >> "$HOME"/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> "$HOME"/.zshrc
    echo 'eval "$(pyenv init -)"' >> "$HOME"/.zshrc
}


function install_python() {
    # This is what is added to .zshrc in order to run nvm. It's in there, so I shouldn't need to 
    #   add this, but for whatever reason, `nvm` isn't found when running this function unless this 
    #   is included, even though .zshrc has been sourced. Doesn't make any sense, but this works, 
    #   so it's a problem for another day.
    # NOTE: this might be problematic in some way...
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    # if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)\"
    eval "$(pyenv init -)"

    # gets the system version (minus the word "Python"), then installs that 
    #   version with pyenv and sets it to "global."
    system_python_version=$(python3 --version)

    # `s/.* //` deletes from the beginning to the first space
    python_version=$(echo "$system_python_version" | sed 's/.* //')

    pyenv install "$python_version"
    pyenv global "$python_version"
}


function install_rust() {
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    # source ~/.cargo/env
}


function install_github_cli() {
    # add repository
	type -p curl >/dev/null || sudo apt install curl -y
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \

	sudo apt update && sudo apt install gh -y
}


function install_oh_my_zsh() {
    # interactive
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # unattended -- can't use right now
    # sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # FIXME: the following doesn't work!
    # `< /dev/tty` forces that new shell to start reading input from the terminal. 
    #   Without this, the script would exit, returning to your calling script. I 
    #   don't want this to happen - I want more functions to run aftr this.
    # exec zsh < /dev/tty
}

function main() {
    install_from_package_manager
}


main
