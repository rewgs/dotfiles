# personal connections and computers
alias nas="ssh rewgs@rewgs-nas"

# personal bin

if [[ -d "$HOME/bin" ]]; then
    alias b="cd $HOME/bin"
fi
if [[ -d "$HOME/second-brain" ]]; then
    alias B="cd $HOME/second-brain"
fi

# dotfiles
alias dotfiles="cd $DOTFILES"
alias dots="cd $DOTFILES"
alias d="cd $DOTFILES"

# work dirs
if [[ $(uname) == "Darwin" ]]; then
    alias naswork="cd /Volumes/main/projects"
fi

# sns dirs
alias work="cd $HOME/work/"
alias sns="cd $HOME/work/sns/"
alias snsd="cd $HOME/work/sns/development/"
alias snstodo="cd $HOME/work/sns/sns-to-do/ && nvim README.md"
