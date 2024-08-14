# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# configures the `fuck` command
if command -v thefuck &> /dev/null; then
    eval $(thefuck --alias)
fi

# scales the display to 2x
# this is only for Parallels on M1 Mac
# if [[ $(uname) == "Linux" ]] && [[ $(echo $HOST) == "ubuntu-linux-22-04-desktop" ]]; then
#     sway output "Virtual-1" scale 2
# fi

if command -v broot &> /dev/null; then
    if [[ $(uname) == "Darwin" ]]; then
        source /Users/rewgs/.config/broot/launcher/bash/br
    fi
fi

# nvm
if command -v nvm &> /dev/null; then
    nvm use node > /dev/null
fi
