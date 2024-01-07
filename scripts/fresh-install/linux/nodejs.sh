install_nvm_from_source () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone --depth 1 https://github.com/nvm-sh/nvm.git
    ln -s "$HOME"/src/nvm/ "$HOME"/.nvm
}


prep_for_nvm_nodejs_installs () {
    echo 'export NVM_DIR=\\"\$([ -z \"\${XDG_CONFIG_HOME-}\" ] && printf %s \"\${HOME}/.nvm\" || printf %s \"\${XDG_CONFIG_HOME}/nvm\")\"' >> "$HOME"/.bashrc
    echo '[ -s \"\$NVM_DIR/nvm.sh\\" ] && \\. \"\$NVM_DIR/nvm.sh\"' >> "$HOME"/.bashrc

    echo 'export NVM_DIR=\\"\$([ -z \"\${XDG_CONFIG_HOME-}\" ] && printf %s \"\${HOME}/.nvm\" || printf %s \"\${XDG_CONFIG_HOME}/nvm\")\"' >> "$HOME"/.zshrc
    echo '[ -s \"\$NVM_DIR/nvm.sh\\" ] && \\. \"\$NVM_DIR/nvm.sh\"' >> "$HOME"/.zshrc
}


install_nodejs () {
    # This is what is added to .zshrc in order to run nvm. It's in there, so I shouldn't need to 
    #   add this, but for whatever reason, `nvm` isn't found when running this function unless this 
    #   is included, even though .zshrc has been sourced. Doesn't make any sense, but this works, 
    #   so it's a problem for another day.
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # installs absolute latest version
    nvm install node    

    # installs lts version
    nvm install --lts   

    # sets latest version as default for each shell
    nvm alias default node
}


install_npm_apps () {
    nvm use --lts

    typeset -a npm_apps
    npm_apps=(
        "gtop -g"
    )

    for app in "${npm_apps[@]}"; do
        npm install "$app"
    done
}
