ZSH_THEME="robbyrussell"

# Courtesy of the zsh-nvm plugin
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

plugins=(
    docker
    evalcache
    git 
    zsh-nvm
)


export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
