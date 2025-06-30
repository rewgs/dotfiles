# ╔═════════════════════════════════════════════════════════════════════════════╗
# ║ .zshrc is for interactive shells. You set options for the interactive shell ║
# ║ there with the setopt and unsetopt commands. You can also load shell        ║
# ║ modules, set your history options, change your prompt, set up zle and       ║
# ║ completion, etc. You also set any variables that are only used in the       ║
# ║ interactive shell (e.g. $LS_COLORS).                                        ║
# ║                                                                             ║
# ║ In an effort to keep this maintainable, this file has been split into       ║
# ║ multiple files. .zshrc now sources other files definied in $ZSH_CONFIG.     ║
# ╚═════════════════════════════════════════════════════════════════════════════╝

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ functions                                                                  ║
# ╚════════════════════════════════════════════════════════════════════════════╝

recursively_source_zfuncs() {
    local dir="$1"
    for file in "$dir"/*; do
        if [[ -d "$file" ]]; then
            recursively_source_zfuncs "$(realpath "$file")"
        else
            autoload -Uz "$file"; 
        fi
    done
}

recursively_source_aliases() {
    local dir="$1"
    for file in "$dir"/*; do
        if [[ -d "$file" ]]; then
            recursively_source_aliases "$(realpath "$file")"
        else
            source "$file"
        fi
    done
}

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ shell setup                                                                ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# history
SAVEHIST=1000
HISTSIZE=1000
HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY_TIME # See for details: https://unix.stackexchange.com/questions/389881/history-isnt-preserved-in-zsh/389883#389883

# functions and aliases
FPATH="$ZFUNCS:$FPATH"
recursively_source_zfuncs "$ZFUNCS"
recursively_source_aliases "$ZALIASES"

# vi mode
source "$ZDOTDIR/vi.zsh"

# NOTE: Moved to the bottom so that things like homebrew completion work.
# autocomplete
# autoload -Uz compinit; compinit
# _comp_options+=(globdots) # With hidden files
# source "$ZDOTDIR/completion.zsh"
# source "$ZDOTDIR/tailscale.zsh"

# prompt
# NOTE: Not using -- replaced with Starship.
# source "$ZDOTDIR/prompt.zsh"

# Somewhere along the line, ctrl+shift+tab stopped working.
# This sets it.
bindkey '^[[Z' reverse-menu-complete

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ plugins - pre-RCs                                                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝

SRC="$HOME/src"
ZPLUGINS="$SRC/zsh-plugins"
# export "$SRC"
# export "$ZPLUGINS"

# zsh-smart-cache
# source "$HOME/src/zsh-plugins/zsh-smartcache/zsh-smartcache.plugin.zsh"
source "$ZPLUGINS/zsh-smartcache/zsh-smartcache.plugin.zsh"

# zsh-completions
# fpath=($HOME/src/zsh-plugins/zsh-completions/src $fpath)
fpath=("$ZPLUGINS/zsh-completions/src" $fpath)

# zsh per-directory history
# source "$HOME/src/zsh-plugins/per-directory-history/per-directory-history.zsh"
source "$ZPLUGINS/per-directory-history/per-directory-history.zsh"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ run commands                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# my bin repo
if [[ -d "$HOME/bin/src" ]] || [[ -L "$HOME/bin/src" ]]; then
    export BIN="$HOME/bin/src"
    export PATH="$BIN:$PATH"
fi

# Fix for ghostty -- allows tmux over ssh to work properly
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi

# broot
if command -v broot &> /dev/null; then
    broot="$HOME/.config/broot"
    if [[ $(uname) == "Darwin" ]]; then
        if [[ -d "$broot" ]] || [[ -L "$broot" ]]; then
            source "$broot/launcher/bash/br"
        fi
    fi
fi

# bun
if [[ -d "$HOME/.bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"

    # bun completions
    [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
fi

# fvm (Flutter Version Manager)
# https://github.com/leoafarias/fvm
# https://stackoverflow.com/a/72811898/7994254
if [[ -d "$HOME/fvm/default/bin" ]]; then
    export PATH="$PATH:$HOME/fvm/default/bin"
fi

# fzf
# sources fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FIXME:Apparently the --tmux option *isn't* silently ignored. Just a Linux issue maybe?
# Sets fzf to open in a tmux popup.
# Centered, 85% width/50% height.
# (`--tmux` is silently ignored if not running in a tmux session).
# export FZF_DEFAULT_OPTS='--tmux 85%,50%'

# homebrew - Linux (NOTE: macOS brew is handedl in .zshenv)
if [[ "$(uname)" == "Linux" ]] && [[ -d "/home/linuxbrew" ]]; then
    # NOTE: Using `smartcache eval` doesn't appear to work
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    HOMEBREW_NO_ENV_HINTS=1
    HOMEBREW_NO_AUTO_UPDATE=1 # Prevents homebrew from automatically updating all packages when installing a package.
    HOMEBREW_NO_INSTALL_UPGRADE=1
fi

# lua/luarocks
if command -v luarocks &> /dev/null; then
    # eval $(luarocks path)
    smartcache eval luarocks path
fi

# munki
if [[ $(uname) == "Darwin" ]] && [[ -d "/usr/local/munki/" ]]; then
    export PATH="$PATH:/usr/local/munki/"
fi

# nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# phpenv
if [[ -d "$HOME/.phpenv" ]] || [[ -L "$HOME/.phpenv" ]]; then
    export PATH="$HOME/.phpenv/bin:$PATH"
    # eval "$(phpenv init -)"
    smartcache eval phpenv init -
fi

# pyenv
PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT" ]] || [[ -L "$PYENV_ROOT" ]]; then
    export PYENV_ROOT
    export PATH="$PYENV_ROOT/bin:$PATH"
    # eval "$(pyenv init -)"
    smartcache eval pyenv init -
fi

# rbenv
if [[ -d "HOME/.rbenv" ]] || [[ -L "$HOME/.rbenv" ]]; then
    if [[ "$(uname)" == "Darwin" ]]; then
        smartcache eval ~/.rbenv/bin/rbenv init - zsh
    fi

    # FIXME: smartcache isn't working for rbenv on Linux. Results in `command not found`.
    if [[ "$(uname)" == "Linux" ]]; then
        eval "$(~/.rbenv/bin/rbenv init - zsh)"
    fi

    FPATH=~/.rbenv/completions:"$FPATH"
    autoload -U compinit
    compinit
fi

# rust
if [[ -d "$HOME/.cargo" ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# thefuck
if command -v thefuck &> /dev/null; then 
    # eval $(thefuck --alias)
    smartcache eval thefuck --alias
fi

# volta (alternative to nvm, fnm, etc)
if [[ -d "$HOME/.volta" ]]; then
    export VOLTA_HOME="$HOME/.volta"
    # export PATH="$PATH:$VOLTA_HOME/bin" # appending
    export PATH="$VOLTA_HOME/bin:$PATH" # prepending
fi

# yazi
source "$ZDOTDIR/yazi.zsh"

# sns
if [[ -f "$HOME/.sns/env/shell/main.sh" ]]; then
    source "$HOME/.sns/env/shell/main.sh"
fi

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ plugins - post-RCs                                                         ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# TODO: Add setup script for this.
# autocomplete
# source "$HOME/src/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
# bindkey              '^I' menu-select
# bindkey "$terminfo[kcbt]" menu-select
# bindkey -M menuselect              '^I'         menu-complete
# bindkey -M menuselect "$terminfo[kcbt]" reverse-menu-complete

# fzf-tab
# source "$ZDOTDIR/fzf-tab.zsh"

# Syntax highlighting
# NOTE: This must be last
# if [[ -d "$HOME/src/zsh-syntax-highlighting" ]] || [[ -L "$HOME/src/zsh-syntax-highlighting" ]]; then
#     source "$HOME/src/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# fi

# autocomplete
# autoload -Uz compinit; compinit
# _comp_options+=(globdots) # With hidden files
# source "$ZDOTDIR/tailscale.zsh"
source "$ZDOTDIR/completion.zsh"

# Starship
eval "$(starship init zsh)"
