#!/usr/bin/bash

install_nvm_from_source () {
    local src="$HOME/src"
    local dst="$HOME/.config"

    if [[ ! -d "$src" ]]; then mkdir "$src"; fi
    if [[ ! -d "$dst" ]]; then mkdir "$dst"; fi

    cd "$src" || return
    git clone --depth 1 https://github.com/nvm-sh/nvm.git
    ln -s "$src/nvm" "$dst/nvm"
}


install_nodejs () {
    # This is what is added to .zshrc in order to run nvm. It's in there, so I shouldn't need to 
    #   add this, but for whatever reason, `nvm` isn't found when running this function unless this 
    #   is included, even though .zshrc has been sourced. Doesn't make any sense, but this works, 
    #   so it's a problem for another day.
    # export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # installs absolute latest version
    nvm install node    

    # installs lts version
    nvm install --lts   

    # sets latest version as default for each shell
    nvm alias default node
}


install_npm_apps () {
    typeset -a npm_apps
    npm_apps=(
        "gtop -g"
    )

    for app in "${npm_apps[@]}"; do
        npm install "$app"
    done
}


main_1 () {
    install_nvm_from_source
}

main_2 () {
    install_nodejs
    install_npm_apps
}

# main_1
# main_2 # requires shell to be sourced before running
