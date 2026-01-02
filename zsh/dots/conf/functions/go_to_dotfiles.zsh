# NOTE: This provides tab completion.
function _go_to_dotfiles() {
    local state cur context line

    local dirs=$(ls -d $DOTFILES/*)
    for dir in "${dirs[@]}"; do
        echo "$dir"
    done
}

function go_to_dotfiles() {
    if [[ ! -n "${DOTFILES+x}" ]]; then
        echo "environment variable DOTFILES not set."
        return 1
    fi
    
    local num_args="$#"
    if [[ "${num_args}" -eq 0 ]]; then
        cd "${DOTFILES}"
        return 0
    fi
    
    local dst="$DOTFILES"
    for arg in "$@"; do
        dst="${dst}/${arg}"
    done

    if [[ ! -d "${dst}" ]]; then
        echo "directory does not exist: ${dst}"
        return 1
    fi

    cd "$dst"
    return 0
}
