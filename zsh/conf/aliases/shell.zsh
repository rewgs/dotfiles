alias es="exec $SHELL && source_shell"


# zshrc
alias z="$EDITOR $HOME/.zshrc"
alias sz="source $HOME/.zshrc"
alias ss="source_shell"

# common commands and functions
alias c="clear"

if [[ $(uname) == "Darwin" ]] || [[ $(uname) == "Linux" ]]; then
    alias ls=ls_improved
elif [[ $(uname) == "FreeBSD" ]]; then
    alias ls="ls -al"
fi

alias cls=clear_then_ls_improved
alias eh="echo 'You are using $HOST'"
alias mkd="mkdir"
alias mv="mv -i"
# alias mv=mvi # `mvi()` is a function of mine, located at `$DOTFILES/zsh/conf/functions/`.
alias rm=rmi # `rmi()` is a function of mine, located at `$DOTFILES/zsh/conf/functions/`.
alias sdo=run_as_sudo

alias powershell=pwsh
