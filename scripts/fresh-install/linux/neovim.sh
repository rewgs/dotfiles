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
    src="https://github.com/wbthomason/packer.nvim"
    dst="$HOME/.local/share/nvim/site/pack/packer/start/"

    if [ ! -d "$dst" ]; then
        mkdir -p "$dst"
    fi

	git clone --depth 1 "$src" $"dst"
}


function install_neovim() {
    # install_neovim_dependencies
    # install_neovim_from_source
    install_packer_nvim
}
