install_apt_build_dependencies () {
	apt update; 
	apt install -y \
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

install_pacman_build_dependencies () {
    sudo pacman -S --needed \
        base-devel \
        openssl \
        zlib \
        xz \
        tk
}


install_pyenv_from_source () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/pyenv/pyenv.git
    ln -s "$HOME"/src/pyenv/ "$HOME"/.pyenv
}
