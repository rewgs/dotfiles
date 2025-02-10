# common commands and functions
alias c="clear"
alias cls=clear_then_ls_improved
alias es="exec $SHELL"
alias ss=source_shell

if [[ "$(uname)" == "Darwin" ]]; then
    alias ls="gls --color=always --group-directories-first"
elif [[ "$(uname)" == "FreeBSD" ]]; then
    alias ls="ls -al"
elif [[ "$(uname)" == "Linux" ]]; then
    alias ls="ls --color=always --group-directories-first"
fi

alias eh="echo 'You are using $HOST'"
alias mkd="mkdir"
alias mv="mv -i"
# alias mv=mvi # `mvi()` is a function of mine, located at `$DOTFILES/zsh/conf/functions/`.
# alias rm=rmi # `rmi()` is a function of mine, located at `$DOTFILES/zsh/conf/functions/`.
alias sdo=run_as_sudo

alias powershell=pwsh

# editors that aren't (n)vim
alias h="hx"    # helix
alias k="kak"   # kakoune
alias n="nano"  # nano

alias fetch="if command -v fastfetch &> /dev/null; then fastfetch; else neofetch; fi"

# GNU utils on macOS
if [[ $(uname) == "Darwin" ]]; then
    alias sed="gsed"
    # alias grep="ggrep"
fi

# xplr
alias x="xplr"

# yazi
alias y="yazi"

if [[ "$(uname)" == "Linux" ]]; then
    alias open="xdg-open"
fi
