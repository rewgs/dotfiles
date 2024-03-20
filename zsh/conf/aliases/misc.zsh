# TODO: fix this, not currently working
alias b="br" # invokes broot in power-user mode (br)

# editors that aren't (n)vim
alias h="hx"    # helix
alias k="kak"   # kakoune
alias n="nano"  # nano

alias f="fzf"

# sed
if [[ $(uname) == "Darwin" ]]; then
    alias sed="gsed"
fi

# xplr
alias x="xplr"
