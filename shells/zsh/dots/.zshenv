# Source shared environment (sets XDG, OS_NAME, EDITOR, PATH, etc.)
source "${${(%):-%x}:A:h:h:h:h}/shells/common/env.sh"

# zsh-specific vars (depend on XDG_CONFIG_HOME from env.sh)
# NOTE: once ZDOTDIR is exported here, every later zsh process inherits it, so zsh
# looks for its *next* .zshenv at $ZDOTDIR/.zshenv instead of ~/.zshenv. conf/.zshenv
# (symlinked to this file) exists so that lookup still resolves back here.
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZFUNCS="$ZDOTDIR/functions"
export ZALIASES="$ZDOTDIR/aliases"

export SAVEHIST=10000

# OrbStack (macOS, zsh-specific init script)
if [[ "$OS_NAME" == "Darwin" ]]; then
    source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi
