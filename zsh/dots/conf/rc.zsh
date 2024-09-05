# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# configures the `fuck` command
if command -v thefuck &> /dev/null; then eval $(thefuck --alias); fi

if command -v broot &> /dev/null; then
    if [[ $(uname) == "Darwin" ]]; then
        source /Users/rewgs/.config/broot/launcher/bash/br
    fi
fi

# nvm
if command -v nvm &> /dev/null; then
    nvm use node > /dev/null
fi
