#!/bin/bash
#
# Installs rbenv and ruby-build.


_SRC="$HOME/src"

install_rbenv_build_dependencies() {
    typeset -a apt_deps
    apt_deps=(
        "autoconf"
        "build-essential"
        "libdb-dev"
        "libffi-dev"
        "libgdbm-dev"
        "libgdbm6"
        "libgmp-dev"
        "libncurses5-dev"
        "libreadline6-dev"
        "libssl-dev"
        "libyaml-dev"
        "patch"
        "rustc"
        "uuid-dev"
        "zlib1g-dev"
    )

    typeset -a pacman_deps
    pacman_deps=(
        "base-devel"
        "libffi"
        "libyaml"
        "openssl"
        "rust"
        "zlib"
    )

    # FIXME: does this work?
	. "$1/distros.sh"

	if [[ $(get_distro) == *"Debian"* ]] || [[ $(get_distro) == *"Ubuntu"* ]]; then
		for d in "${apt_deps[@]}"; do
			sudo apt-get install -y "$d"
		done
	elif [[ $(get_distro) == *"Arch"* ]]; then
		for d in "${pacman_deps[@]}"; do
			sudo pacman -Syuq --needed --noconfirm "$d"
		done
	fi
}


clone_git_repo() {
    # `git clone`s the rbenv distro to `~/src/$REPO_NAME` via https.
    # If successful, returns the path to the repo.

    local SRC="$1" # URL
    local DOMAIN=$(echo ${SRC} | awk -F'/' '{print $1FS$2FS$3}')    
    local ORG=$(echo ${SRC} | awk -F'/' '{print $4}')    
    local REPO=$(echo ${SRC} | awk -F'/' '{print $5}')
    local REPO_NAME=$(echo "$REPO" | sed -e "s/".git"$//")
    local DST="$_SRC/$REPO_NAME"

    if [[ ! -d "$_SRC" ]]; then mkdir "$_SRC"; fi
    if [[ ! -d "$DST" ]]; then git clone --depth 1 "$SRC" "$DST"; fi

    if [[ ! -d "$DST/.git" ]]; then exit 1; fi
    echo "$DST"
}


setup_rbenv() {
    local SRC="$1"
    local DST="$HOME/.rbenv"

    if [[ ! -L "$DST" ]]; then ln -s "$SRC" "$DST"; fi
}


setup_rubybuild() {
    local SRC="$1"
    local DST_DIR="$HOME/.rbenv/plugins"
    local DST="$DST_DIR/ruby-build"

    if [[ ! -d "$DST_DIR" ]]; then mkdir -p "$DST_DIR"; fi
    if [[ ! -L "$DST" ]]; then ln -s "$SRC" "$DST"; fi

}


main () {
    local RBENV_URL="https://github.com/rbenv/rbenv.git"
    local RUBYBUILD_URL="https://github.com/rbenv/ruby-build.git"

    local rbenv_dst=$(clone_git_repo "$RBENV_URL")
    local rubybuild_dst=$(clone_git_repo "$RUBYBUILD_URL")
    # echo "$rbenv_dst"
    # echo "$rubybuild_dst"

    setup_rbenv "$rbenv_dst"
    setup_rubybuild "$rubybuild_dst"

    ~/.rbenv/bin/rbenv init

    # assuming that rbenv was installed to `~/.rbenv`
    local DOTFILE="$DOTFILES/zsh/dots/conf/path.zsh"
    echo 'FPATH=~/.rbenv/completions:"$FPATH"' >> "$DOTFILE"
    echo 'autoload -U compinit' >> "$DOTFILE"
    echo 'compinit' >> "$DOTFILE"
}
main
