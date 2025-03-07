places::alias() {
    local DST="$1"
    local ALIAS="$2"
    if [[ -d "$DST" ]]; then
        alias "$ALIAS"="cd $DST"
    fi
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
