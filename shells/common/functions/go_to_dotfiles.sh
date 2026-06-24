go_to_dotfiles() {
    if [ -z "$DOTFILES" ]; then
        echo "environment variable DOTFILES not set."
        return 1
    fi

    if [ "$#" -eq 0 ]; then
        cd "$DOTFILES"
        return 0
    fi

    local dst="$DOTFILES"
    for arg in "$@"; do
        dst="$dst/$arg"
    done

    if [ ! -d "$dst" ]; then
        echo "directory does not exist: $dst"
        return 1
    fi

    cd "$dst"
}
