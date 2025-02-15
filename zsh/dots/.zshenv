# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ functions                                                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# TODO: Move to zfuncs?
get_dotfiles_path() {
    local this_file="$(realpath "${(%):-%x}")"

    local dots="$(realpath "$(dirname "$this_file")")"
    if [[ "$(basename "$dots")" != "dots" ]]; then 
        return 1
    fi

    local zsh="$(dirname "$dots")"
    if [[ "$(basename "$zsh")" != "zsh" ]]; then 
        return 1
    fi

    local dotfiles="$(dirname "$zsh")"
    if [[ "$(basename "$dotfiles")" != "dotfiles" ]]; then 
        return 1
    fi

    echo "$(realpath "$dotfiles")"
}


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ environment variables                                                      ║
# ╚════════════════════════════════════════════════════════════════════════════╝

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_DATA_HOME="$HOME/.local/share"

export HISTSIZE=10000 # Maximum events for internal history
export SAVEHIST=10000 # Maximum events in history file

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZFUNCS="$ZDOTDIR/functions"
export ZALIASES="$ZDOTDIR/aliases"

# Moved to zshrc
# export SRC="$HOME/src"
# export ZPLUGINS="$SRC/zsh-plugins"

export EDITOR='nvim'
export DOTFILES="$(get_dotfiles_path)"

# browser
if [[ "$(uname)" == "Linux" ]]; then
    export BROWSER="$(which firefox)"
elif [[ "$(uname)" == "Darwin" ]]; then
    export BROWSER="/Applications/Firefox.app/Contents/MacOS/firefox"
fi

# my bin repo
if [[ -d "$HOME/bin/src" ]] || [[ -L "$HOME/bin/src" ]]; then
    export BIN="$HOME/bin/src"
    if [[ $(uname) == "Darwin" ]]; then
        export PATH=$PATH:$(find "$BIN" -type d | paste -sd ":" -)
    elif [[ $(uname) == "Linux" ]]; then
        export PATH=$PATH:$(find "$BIN" -type d | paste -sd ":" -)
    fi
fi



# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ PATH                                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# NOTE: on $PATH
# - prepending $PATH: assures that the system looks in this custom path *after* 
#   searching default locations first.
# - appending :$PATH assures that the system looks in this custom path *before* 
#   searching default locations.

# other user bin directories
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# broot
if [[ -d "$XDG_CONFIG_HOME/broot" ]]; then
    export PATH="$XDG_CONFIG_HOME/broot/launcher/bash:$PATH"
fi

# flutter
export PATH="$HOME/src/flutter/bin:$PATH"

# golang
export GOPATH="$HOME/go"
export PATH="$GOPATH:$PATH"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# homebrew
if [[ $(uname) == "Darwin" ]]; then
    export PATH="$PATH:/opt/homebrew/bin"
    export PATH="$PATH:/opt/homebrew/sbin"
    export PATH="$PATH:/opt/homebrew/Cellar"
fi
HOMEBREW_NO_ENV_HINTS=1
HOMEBREW_NO_AUTO_UPDATE=1 # Prevents homebrew from automatically updating all packages when installing a package.
HOMEBREW_NO_INSTALL_UPGRADE=1

# jetbrains
if [[ $(uname) == "Darwin" ]]; then
    export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
elif [[ $(uname) == "Linux" ]]; then
    export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
fi

# nim
export PATH="$PATH:$HOME/.nimble/bin"

# Added by OrbStack: command-line tools and integration
if [[ $(uname) == "Darwin" ]]; then
    source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi

# poetry
if [[ -d "HOME/.poetry" ]] || [[ -L "$HOME/.poetry" ]]; then
    export PATH="$PATH:$HOME/.poetry/bin"
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
if [[ -d "$HOME/.cargo" ]]; then
    . "$HOME/.cargo/env"
    export PATH="$HOME/.cargo/bin:$PATH"
fi
