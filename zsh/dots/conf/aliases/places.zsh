# personal connections and computers
alias macmini="ssh rewgs@rewgs-mac-mini.local"
alias nas="ssh rewgs@rewgs-nas"

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
