#!/usr/bin/bash

# -u: If a variable does not exist, report the error and stop (e.g., unbound 
#   variable)
# -e: Terminate whenever an error occurs (e.g., command not found)
# -o pipefail: 	If a sub-command fails, the entire pipeline command fails, 
#   terminating the script (e.g., command not found)
# set -eu -o pipefail
# Commenting this out because apparently it's making my main() fail when it has no args...
# set -eu # apparently `-o pipefail` isn't legal in POSIX shell


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

function install_from_package_manager () {
    echo "Checking for updates..."
    sudo apt-get update -qq

    # `$?` is used to find the return value of the last executed command
	if [ $? -eq 0 ]; then 
		echo "Upgrading packages..."
		sudo apt-get upgrade -qq -y
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


function remove_snap () {
    # FIXME: 
    # - POSIX sh doesn't support globbing. Convert the following line to case statements.
    # - ^ isn't urgent, as right now I'm only running this on apt-based distros.
    #   Will matter more once I adapt this to be distro-agnostic.
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


function build_tmux_from_source () {
    # for building new and updating
    cd "$HOME"/src/tmux
    git pull
    sh autogen.sh
    ./configure && make

    # apparently there's no 'clean' option?
    # sudo make clean install   
    sudo make install
}


function install_tmux_from_source () {
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


function install_tmux_package_manager () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/tmux-plugins/tpm.git

    if [ ! -d "$HOME"/.tmux/plugins ]; then mkdir -p "$HOME"/.tmux/plugins; fi
	ln -s "$HOME"/src/tpm "$HOME"/.tmux/plugins/tpm
}


# function install_neovim_dependencies () {
# 	sudo apt-get install -y \
# 		ninja-build \
# 		gettext \
# 		libtool \
# 		libtool-bin \
# 		autoconf \
# 		automake \
# 		g++ \
# 		pkg-config \
# 		unzip \
# 		doxygen
# }


# function update_neovim_from_source () {
# 	cd "$HOME"/src/neovim
# 	git checkout stable
# 	git pull
# 	sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
# 	sudo make clean install
# }


# function install_neovim_from_source () {
#     install_neovim_dependencies

#     if [ ! -d ~/src ]; then mkdir ~/src; fi
#     cd ~/src
#     git clone --depth 1 https://github.com/neovim/neovim.git --branch stable
#     cd ~/src/neovim
# 	make CMAKE_BUILD_TYPE=RelWithDebInfo
# 	sudo make install
# }


# function install_packer_nvim () {
# 	git clone --depth 1 \
# 		https://github.com/wbthomason/packer.nvim \
# 		~/.local/share/nvim/site/pack/packer/start/packer.nvim
# }


function install_nvm_from_source () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/nvm-sh/nvm.git
    ln -s "$HOME"/src/nvm/ "$HOME"/.nvm
}


function install_phpenv_build_prerequisites () {
    sudo apt install -y \
        apache2-dev \
        libcurl4-gnutls-dev \
        libjpeg-dev \
        libonig-dev \
        libtidy-dev \
        libzip-dev \
        re2c
}


function install_phpenv_from_source () {
    # install phpenv
    if [ ! -d ~/src ]; then mkdir ~/src; fi
    cd ~/src
    git clone --depth 1 https://github.com/phpenv/phpenv.git
    ln -s ~/src/phpenv/ ~/.phpenv

    # install php-build -- required to use the `phpenv install` command, which is 99% of what I do with phpenv
    # Not working so commenting out for now.
    # cd ~/src
    # git clone --depth 1 https://github.com/php-build/php-build.git
    # if [ ! -d ~/.phpenv/plugins ]; then mkdir -p ~/.phpenv/plugins; fi
    # ln -s ~/src/php-build/ ~/.phpenv/plugins/php-build

    # required for phpenv to see php-build
    # should also be run after each new version of php is installed
    # phpenv rehash
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


function install_pyenv_from_source () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/pyenv/pyenv.git
    ln -s "$HOME"/src/pyenv/ "$HOME"/.pyenv
}




function prep_for_nvm_nodejs_installs () {
    echo 'export NVM_DIR=\\"\$([ -z \"\${XDG_CONFIG_HOME-}\" ] && printf %s \"\${HOME}/.nvm\" || printf %s \"\${XDG_CONFIG_HOME}/nvm\")\"' >> "$HOME"/.bashrc
    echo '[ -s \"\$NVM_DIR/nvm.sh\\" ] && \\. \"\$NVM_DIR/nvm.sh\"' >> "$HOME"/.bashrc

    echo 'export NVM_DIR=\\"\$([ -z \"\${XDG_CONFIG_HOME-}\" ] && printf %s \"\${HOME}/.nvm\" || printf %s \"\${XDG_CONFIG_HOME}/nvm\")\"' >> "$HOME"/.zshrc
    echo '[ -s \"\$NVM_DIR/nvm.sh\\" ] && \\. \"\$NVM_DIR/nvm.sh\"' >> "$HOME"/.zshrc
}


function install_nodejs () {
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
}


function prep_for_pyenv_python_installs () {
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


function install_python () {
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


function install_rust () {
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    # source ~/.cargo/env
}


function install_github_cli () {
    # add repository
	type -p curl >/dev/null || sudo apt install curl -y
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \

	sudo apt update && sudo apt install gh -y
}


function install_oh_my_zsh () {
    # interactive
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # unattended
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # FIXME: the following doesn't work!
    # `< /dev/tty` forces that new shell to start reading input from the terminal. 
    #   Without this, the script would exit, returning to your calling script. I 
    #   don't want this to happen - I want more functions to run aftr this.
    # exec zsh < /dev/tty
}


function install_fira_code_nerd_font () {
    mkdir ~/.fonts
    cd ~/.fonts
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
    unzip FiraCode.zip
    rm FiraCode.zip
    fc-cache -fv
}


function install_npm_apps () {
    nvm use --lts

    typeset -a npm_apps
    npm_apps=(
        "gtop -g"
    )

    for app in "${npm_apps[@]}"; do
        npm install "$app"
    done
}


function install_cargo_apps () {
    typeset -a cargo_apps
    cargo_apps=(
	    "cargo-audi"
	    "cargo-edit"
	    "cargo-make"
	    "cargo-tarpaulin"
	    "cargo-watch"
        "ytop"
    )

    for app in "${cargo_apps[@]}"; do
        cargo install "$app"
    done
}


function make_dotfiles_symlinks () {
    # bash
    typeset -a bash_dots
    bash_dots=(
        "bashrc"
        "bash_profile"
    )
    for d in "${bash_dots[@]}"; do
        if [ -f "$HOME/.$d" ] || [ -h "$HOME/.$d" ]; then
            rm "$HOME/.$d"
        fi
        ln -s "$HOME/dotfiles/bash/$d" "$HOME/.$d"
    done

    # nvim
    if [ ! -d "$HOME/.config" ]; then
        mkdir "$HOME/.config"
    fi
    if [ -d "$HOME/.config/nvim" ] || [ -h "$HOME/.config/nvim" ]; then
        rm "$HOME/.config/nvim"
    fi
    ln -s "$HOME/dotfiles/nvim/" "$HOME/.config/nvim"

    # sh
    if [ -f "$HOME/.profile" ] || [ -h "$HOME/.profile" ]; then
        rm "$HOME/.profile"
    fi
    ln -s "$HOME/dotfiles/sh/profile" "$HOME/.profile"

    # tmux
    if [ -f "$HOME/.tmux.conf" ] || [ -h "$HOME/.tmux.conf" ]; then
        rm "$HOME/.tmux.conf"
    fi
    ln -s "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"
     
    # tpm
    if [ -h "$HOME"/.tmux/plugins/tpm ]; then
        rm "$HOME"/.tmux/plugins/tpm
    fi
    ln -s "$HOME/src/tpm/" "$HOME/.tmux/plugins/tpm"
    
    # zsh
    typeset -a zsh_dots
    zsh_dots=(
        "zlogin"
        "zlogout"
        "zprofile"
        "zshenv"
        "zshrc"
    )
    for z in "${zsh_dots[@]}"; do
        if [ -f "$HOME/.$z" ] || [ -h "$HOME/.$z" ]; then
            rm "$HOME/.$z"
        fi
        ln -s "$HOME/dotfiles/zsh/$z" "$HOME/.$z"
    done

    echo "Symlinking dotfiles complete!"
}


function install_lazygit_from_source () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/jesseduffield/lazygit.git
    cd "$HOME"/src/lazygit
    go install
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


function main () {
    function part1 () {
        # This isn't really working. Commenting out for now.
        # remove_snap

        install_from_package_manager
        install_github_cli

        # tmux
        install_tmux_from_source
        install_tmux_package_manager

        # neovim
        . ./neovim.sh
        install_neovim

        # nodejs
        install_nvm_from_source
        prep_for_nvm_nodejs_installs
        install_nodejs

        # phpenv
        install_phpenv_build_prerequisites
        install_phpenv_from_source

        # pyenv
        install_pyenv_build_dependencies
        install_pyenv_from_source
        prep_for_pyenv_python_installs
        install_python

        install_fira_code_nerd_font

        install_oh_my_zsh
        sudo chsh -s $(which zsh) $(whoami)
        make_dotfiles_symlinks

        echo "All done! Restarting now..."
        sudo reboot
    }


    function part2 () {
        install_npm_apps
        install_rust
        install_cargo_apps
    }


    # Commenting this out once I fix the following block.
    # if $# != 1; then
    #     read -p "Please enter only a 1 or 2:" part
    #     main "$part"
    # fi

    # FIXME: this is failing no matter what. How can I get this to work?
    if "$1" -eq "1"; then
        part1
    elif "$1" -eq "2"; then
        part 2
    else
        read -p "Please enter only a 1 or 2:" part
        main "$part"
    fi
}
main