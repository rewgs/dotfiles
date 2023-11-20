install_phpenv_build_prerequisites () {
    # TODO: make this run on arch like tmux and neovim files
    apt install -y \
        apache2-dev \
        libcurl4-gnutls-dev \
        libjpeg-dev \
        libonig-dev \
        libtidy-dev \
        libzip-dev \
        re2c
}


install_phpenv_from_source () {
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
    # phpenv rehash
}
