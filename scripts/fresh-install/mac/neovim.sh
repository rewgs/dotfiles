#!/usr/bin/env zsh

function install_neovim_build_prerequisites () {
    typeset -a neovim_build_prerequisites
    neovim_build_prerequisites=(
        "cmake"
        "curl"
        "gettext"
        "ninja"
    )

    for prereq in "${neovim_build_prerequisites[@]}"; do
        brew install "$prereq"
    done
}


function update_neovim_from_source () {
	cd "$HOME"/.src/neovim || cd "$HOME"/.src/neovim
	git checkout stable
	git pull
	sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make clean install
}


function build_neovim_from_source () {
    install_neovim_dependencies

    if [ ! -d ~/.src ]; then
        mkdir ~/.src
    fi
    fi

    cd ~/.src
    git clone --depth 1 https://github.com/neovim/neovim.git --branch stable
    cd ~/.src/neovim
	make CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make install
}


function install_packer_nvim () {
    if [ ! -d "$HOME/.local/share/nvim/site/pack/packer/start/" ]; then
        mkdir -p "$HOME/.local/share/nvim/site/pack/packer/start/"
    fi

	git clone --depth 1 \
        https://github.com/wbthomason/packer.nvim \
        "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
}
