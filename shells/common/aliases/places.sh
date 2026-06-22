_places_alias() {
    local dst="$1"
    local alias_name="$2"
    if [ -d "$dst" ]; then
        alias "$alias_name"="cd $dst"
    fi
}

# personal bin
_places_alias "$HOME/bin" "b"

# second brain
_places_alias "$HOME/second-brain" "B"

# dotfiles
_places_alias "$DOTFILES" "d"

# src
_places_alias "$HOME/src" "s"

# tapeop
_places_alias "$HOME/work/TapeOp" "to"
_places_alias "$HOME/work/TapeOp/development" "tod"
