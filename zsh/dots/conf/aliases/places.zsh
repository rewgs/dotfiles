places::alias() {
    local DST="$1"
    local ALIAS="$2"
    if [[ -d "$DST" ]]; then
        alias "$ALIAS"="cd $DST"
    fi
}

function go_to_dotfiles() {
    local num_args="$#"

    if [[ "$num_args" -eq 0 ]]; then
        if [[ -n "${DOTFILES+x}" ]]; then
            cd "$DOTFILES"
            return
        fi

        echo "environment variable DOTFILES not set."
        return
    fi

    local dst="$DOTFILES"
    for arg in "$@"; do
        dst="${dst}/${arg}"
    done

    # TODO: Check if $dst exists before cd

    cd "$dst"
    return
}

# personal bin
places::alias "$HOME/bin" "b"

# second brain
places::alias "$HOME/second-brain" "B"

# dotfiles
places::alias "$DOTFILES" "d"

# src
places::alias "$HOME/src" "s"

# tapeop
places::alias "$HOME/work/TapeOp" "to"
places::alias "$HOME/work/TapeOp/development" "tod"
