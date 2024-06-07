# Notes:
# - prepending $PATH: assures that the system looks in this custom path *after* 
#   searching default locations first.
# - appending :$PATH assures that the system looks in this custom path *before* 
#   searching default locations.

# bin repo
if [[ -d "$HOME/bin" ]] || [[ -L "$HOME/bin" ]]; then
    export REWGS_BIN="$HOME/bin"
    # export PATH="$REWGS_BIN:$PATH"
    # for dir in "$REWGS_BIN/*/"; do
    #     PATH+=":$dir"
    # done

    if [[ $(uname) == "Darwin" ]]; then
        # export PATH=$PATH:$(find "$REWGS_BIN" -type d -maxdepth 1 | paste -sd ":" -)
        export PATH=$PATH:$(find "$REWGS_BIN" -type d | paste -sd ":" -)
    elif [[ $(uname) == "Linux" ]]; then
        # export PATH=$PATH:$(find "$REWGS_BIN" -maxdepth 1 -type d | paste -sd ":" -)
        export PATH=$PATH:$(find "$REWGS_BIN" -type d | paste -sd ":" -)
    fi
fi


# other user bin directories
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# broot
# source $HOME/.config/broot/launcher/bash/br
export PATH="$HOME/.config/broot/launcher/bash:$PATH"

# flutter
export PATH="$HOME/src/flutter/bin:$PATH"

# golang
# export GOPATH="$HOME/go"
# export GOBIN="$GOPATH/bin"
# export PATH="$GOPATH:$PATH"
# export PATH="$GOBIN:$PATH"

# jetbrains
if [[ $(uname) == "Darwin" ]]; then
    export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
elif [[ $(uname) == "Linux" ]]; then
    export PATH="$HOME/opt/JetBrains:$PATH"
fi

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" 
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# phpenv
# NOTE:
# - .phpenv is symlinked to ~/src/phpenv; repo cloned from github (https://github.com/phpenv/phpenv)
# - In order to use the `phpenv install` command, one must also install php-build 
#   (https://github.com/php-build/php-build); symlink ~/src/php-build to ~/.phpenv/plugins/php-build
export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init -)"

# pyenv
# the following must be in both .zshrc (for interactive login shells) and .zprofile (for non-interactive login shells)
# NOTE: .pyenv is symlinked to ~/src/pyenv, repo cloned from github
if [[ $(uname) == "Darwin" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
elif [[ $(uname) == "Linux" ]]; then
    # This checks if the current shell is WSL.
    if [[ $(grep -i Microsoft /proc/version) ]]; then
        # On a machine that has pyenv-win installed on the Windows side, as this messes with the 
        # usual $PYENV_ROOT and tries to run `eval "$(pyenv init -)"` in 
        # `/mnt/c/Users/"$(whoami)"/.pyenv` and thus returns a `bad interpreter` error.
        export PYENV_ROOT="/home/"$(whoami)"/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
    else 
        # The usual works just fine on non-WSL Linux (this is the same as the "Darwin" branch above).
        export PYENV_ROOT="$HOME/.pyenv"
        command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
    fi
fi

# reaper
if [[ $(uname) == "Darwin" ]]; then
    alias reaper_exec="/Applications/REAPER.app/Contents/MacOS/REAPER"
    alias REAPER="cd $HOME/Library/Application\ Support/REAPER"
    alias ReaScripts="cd $HOME/Library/Application\ Support/REAPER/Scripts"
    alias rewgsReaScripts="cd $HOME/Library/Application\ Support/REAPER/Scripts/rewgs-reaper-scripts"
elif [[ $(uname) == "Linux" ]]; then
    export PATH="$HOME/opt/REAPER:$PATH"
fi

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# homebrew
if [[ $(uname) == "Darwin" ]]; then
    export PATH="$PATH:/opt/homebrew/bin"
    export PATH="$PATH:/opt/homebrew/sbin"
    export PATH="$PATH:/opt/homebrew/Cellar"
elif [[ "$(uname)" == "Linux" ]] && [[ "$(uname -i)" == "x86_64" ]] && [[ "$(whoami)" != "root" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# nim
export PATH="$PATH:$HOME/.nimble/bin"
    
# poetry
export PATH="$PATH:$HOME/.poetry/bin"
