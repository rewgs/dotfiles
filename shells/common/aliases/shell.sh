alias c="clear"
alias cls=clear_then_ls_improved
alias es="exec $SHELL"
alias ss=source_shell

if [ "$(uname)" = "Darwin" ]; then
    alias ls="gls --color=always --group-directories-first"
elif [ "$(uname)" = "FreeBSD" ]; then
    alias ls="ls -al"
elif [ "$(uname)" = "Linux" ]; then
    alias ls="ls --color=always --group-directories-first"
fi

alias eh="echo 'You are using $HOST'"
alias mkd="mkdir"
alias mv="mv -i"
alias sdo=run_as_sudo

alias powershell=pwsh

# editors that aren't (n)vim
alias h="hx"
alias k="kak"
alias n="nano"

alias fetch="if command -v fastfetch > /dev/null 2>&1; then fastfetch; else neofetch; fi"

# GNU utils on macOS
if [ "$(uname)" = "Darwin" ]; then
    alias sed="gsed"
fi

alias x="xplr"
alias y="yazi"

if [ "$(uname)" = "Linux" ]; then
    alias open="xdg-open"
fi
