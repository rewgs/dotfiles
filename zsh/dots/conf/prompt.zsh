# custom
# fpath=("$ZDOTDIR/prompt.zsh" $fpath)
# autoload -Uz prompt.zsh; prompt.zsh

# TODO: Add setup script for this.
# pure (plugin)
fpath+=($HOME/src/pure)
autoload -U promptinit; promptinit
zstyle ':prompt:pure:prompt:*' color cyan
zstyle ':prompt:pure:path' color cyan
prompt pure
