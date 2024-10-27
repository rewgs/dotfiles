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

FPATH="$ZFUNCS:$FPATH"
recursively_source_zfuncs "$ZFUNCS"
recursively_source_aliases "$ZALIASES"

# vi mode
source "$ZDOTDIR/vi.zsh"

# autocomplete
autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files
source "$ZDOTDIR/completion.zsh"

# prompt
# NOTE: Not using -- replaced with Starship.
# source "$ZDOTDIR/prompt.zsh"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ plugins - pre-RCs                                                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# TODO: Add setup script for this.
source "$HOME/src/zsh-smartcache/zsh-smartcache.plugin.zsh"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ run commands                                                               ║
# ╚════════════════════════════════════════════════════════════════════════════╝

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

# fzf
# Sources fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#
# Sets fzf to open in a tmux popup.
# Centered, 85% width/50% height.
# (`--tmux` is silently ignored if not running in a tmux session).
export FZF_DEFAULT_OPTS='--tmux 85%,50%'

# homebrew
if [[ "$(uname)" == "Linux" ]] && [[ "$(uname -i)" == "x86_64" ]] && [[ "$(whoami)" != "root" ]]; then
    if [[ -d "/home/linuxbrew" ]]; then
        # eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        smartcache eval /home/linuxbrew/.linuxbrew/bin/brew shellenv
    fi
fi

# lua/luarocks
if command -v luarocks &> /dev/null; then
    # eval $(luarocks path)
    # _evalcache luarocks path
    smartcache eval luarocks path
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
    # eval "$(~/.rbenv/bin/rbenv init - zsh)"
    smartcache eval ~/.rbenv/bin/rbenv init - zsh
fi

# thefuck
if command -v thefuck &> /dev/null; then 
    # eval $(thefuck --alias)
    smartcache eval thefuck --alias
fi

# volta (alternative to nvm, fnm, etc)
if [[ -d "$HOME/.volta" ]]; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$PATH:$VOLTA_HOME/bin"
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

# Starship
eval "$(starship init zsh)"
