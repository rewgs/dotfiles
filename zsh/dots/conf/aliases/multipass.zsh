if [[ $(uname) == "Darwin" ]]; then
    alias mpls="multipass list"          # lists all multipass VMs
    alias mpsh="multipass shell ubuntu"  # starts and ssh's into main VM
    alias mpst="multipass start ubuntu"  # starts main VM but doesn't connect to it
    alias mpsp="multipass stop ubuntu"   # stops ubuntu VM
    alias snsmpsh="multipass shell sns"
    alias snsmpst="multipass start sns"
    alias snsmpsp="multipass stop sns"
fi
