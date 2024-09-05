# editors that aren't (n)vim
alias h="hx"    # helix
alias k="kak"   # kakoune
alias n="nano"  # nano

alias f="fzf"

alias fetch="if command -v fastfetch &> /dev/null; then fastfetch; else neofetch; fi"

# sed
if [[ $(uname) == "Darwin" ]]; then
    alias sed="gsed"
fi

# xplr
alias x="xplr"
