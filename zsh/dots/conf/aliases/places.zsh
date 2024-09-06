# personal connections and computers
alias nas="ssh rewgs@rewgs-nas"
alias vm="ssh rewgs@rewgs-nas-debian-vm"

places::alias() {
    local DST="$1"
    local ALIAS="$2"
    if [[ -d "$DST" ]]; then
        alias "$ALIAS"="cd $DST"
    fi
}

# personal bin
# if [[ -d "$HOME/bin" ]]; then
#     alias b="cd $HOME/bin"
# fi
places::alias "$HOME/bin" "b"

# second brain
# if [[ -d "$HOME/second-brain" ]]; then
#     alias B="cd $HOME/second-brain"
# fi
places::alias "$HOME/second-brain" "B"

# dotfiles
# alias dotfiles="cd $DOTFILES"
# alias dots="cd $DOTFILES"
alias d="cd $DOTFILES"
# places::alias "$DOTFILES" "d"

# src
# if [[ -d "$HOME/src" ]]; then
#     alias s="cd $HOME/src"
# fi
places::alias "$HOME/src" "s"

# work dirs
if [[ $(uname) == "Darwin" ]]; then
    alias naswork="cd /Volumes/main/projects"
fi
places::alias "$HOME/work" "w"

# sns dirs
# alias sns="cd $HOME/work/sns/"
# alias snsd="cd $HOME/work/sns/development/"
# alias snstodo="cd $HOME/work/sns/sns-to-do/ && nvim README.md"
places::alias "$HOME/work/sns" "sns"
places::alias "$HOME/work/sns/development" "snsd"
