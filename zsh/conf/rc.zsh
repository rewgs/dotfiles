# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# configures the `fuck` command
eval $(thefuck --alias)

# scales the display to 2x
# this is only for Parallels on M1 Mac
# if [[ $(uname) == "Linux" ]] && [[ $(echo $HOST) == "ubuntu-linux-22-04-desktop" ]]; then
#     sway output "Virtual-1" scale 2
# fi

if [[ $(uname) == "Darwin" ]]; then
    source /Users/rewgs/.config/broot/launcher/bash/br
fi

# nvm
nvm use node > /dev/null
