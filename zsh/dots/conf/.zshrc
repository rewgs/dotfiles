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

# NOTE: Call this function to time zsh startup time.
# Source: https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/#how-to-test-your-shell-load-time
time_startup() {
    local num_loops=3

    local shell=${1-$SHELL}

    # Run as loop
    for i in $(seq 1 $num_loops); do 
        echo "Startup time test number $i of $num_loops:"
        if [[ "$(uname)" == "Darwin" ]]; then
            /usr/bin/time $shell --interactive -c exit
        elif [[ "$(uname)" == "Linux" ]]; then
            time $shell --interactive -c exit
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
# NOTE: conflicts with autocomplete plugins (at end of file) -- use either/or
source "$ZDOTDIR/completion.zsh" # Copied straight from ohmyzsh


# prompt
#
# custom
# fpath=("$ZDOTDIR/prompt.zsh" $fpath)
# autoload -Uz prompt.zsh; prompt.zsh
#
# pure (plugin)
fpath+=($HOME/src/pure)
autoload -U promptinit; promptinit
prompt pure

# Enables tab-to-complete to find dotfiles without typing the leading period.
setopt extendedglob

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

# fnm (nvm alternative)
# FNM_PATH="/home/rewgs/.local/share/fnm"
# if [ -d "$FNM_PATH" ]; then
#     export PATH="/home/rewgs/.local/share/fnm:$PATH"
#     eval "$(fnm env --use-on-cd --shell zsh)"
# fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# homebrew
if [[ "$(uname)" == "Linux" ]] && [[ "$(uname -i)" == "x86_64" ]] && [[ "$(whoami)" != "root" ]]; then
    if [[ -d "/home/linuxbrew" ]]; then
        # eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        # _evalcache "/home/linuxbrew/.linuxbrew/bin/brew shellenv"
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
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# phpenv
if [[ -d "$HOME/.phpenv" ]] || [[ -L "$HOME/.phpenv" ]]; then
    export PATH="$HOME/.phpenv/bin:$PATH"
    # eval "$(phpenv init -)"
    # _evalcache phpenv init -
    smartcache eval phpenv init -
fi

# pyenv
PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT" ]] || [[ -L "$PYENV_ROOT" ]]; then
    export PYENV_ROOT
    export PATH="$PYENV_ROOT/bin:$PATH"
    # eval "$(pyenv init -)"
    # _evalcache pyenv init -
    smartcache eval pyenv init -
fi

# rbenv
if [[ -d "HOME/.rbenv" ]] || [[ -L "$HOME/.rbenv" ]]; then
    # eval "$(~/.rbenv/bin/rbenv init - zsh)"
    # _evalcache ~/.rbenv/bin/rbenv init - zsh
    smartcache eval ~/.rbenv/bin/rbenv init - zsh
fi

# thefuck
if command -v thefuck &> /dev/null; then 
    # eval $(thefuck --alias)
    # _evalcache thefuck --alias
    smartcache eval thefuck --alias
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

# TODO: Add setup script for this.
autoload -U compinit; compinit
source "$HOME/src/fzf-tab/fzf-tab.plugin.zsh"
#
# config:
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Syntax highlighting
# NOTE: This must be last
# if [[ -d "$HOME/src/zsh-syntax-highlighting" ]] || [[ -L "$HOME/src/zsh-syntax-highlighting" ]]; then
#     source "$HOME/src/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# fi
