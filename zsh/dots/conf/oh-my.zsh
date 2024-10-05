ZSH_THEME="robbyrussell"

# NOTE: No longer needed -- using fnm instead of nvm.
# Courtesy of the zsh-nvm plugin
# export NVM_LAZY_LOAD=true
# export NVM_COMPLETION=true

plugins=(
    # docker
    evalcache
    # git 

    # NOTE: No longer needed -- using fnm instead of nvm.
    # zsh-nvm
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
