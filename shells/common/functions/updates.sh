_update_aur() {
    paru -Syu --noconfirm
}

_update_brew() {
    echo "update_brew() yet implemented"
}

_update_pacman() {
    sudo pacman -Syu --noconfirm
}

_update_rustup() {
    echo "update_rustup() yet implemented"
}

uatt() {
    local _os="$(uname)"
    if [ "$_os" = "Darwin" ]; then
        echo "Updating ALL THE THINGS!"
        _update_brew
        _update_rustup
    elif [ "$_os" = "Linux" ]; then
        echo "Updating ALL THE THINGS!"
        _update_pacman
        _update_aur
        _update_brew
        _update_rustup
    else
        echo -e "OS not supported: $_os"
        exit 1
    fi
    exit 0
}
