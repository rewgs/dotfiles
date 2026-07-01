# Source shared environment (sets XDG, OS_NAME, EDITOR, PATH, etc.)
source "${${(%):-%x}:A:h:h:h:h}/shells/common/env.sh"

# zsh-specific vars (depend on XDG_CONFIG_HOME from env.sh)
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZFUNCS="$ZDOTDIR/functions"
export ZALIASES="$ZDOTDIR/aliases"

export SAVEHIST=10000

# OrbStack (macOS, zsh-specific init script)
if [[ "$OS_NAME" == "Darwin" ]]; then
    source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi
