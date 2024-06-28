# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ basic interactive shell settings                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝


LS_COLORS="ow=01;93;40:ln=00;35;40:ex=00;31;40:*.mp3=00;32;40:*.wav=00;32;40:*.aif=00;32;40:*.aiff=00;32;40"
export LS_COLORS

# configures Homebrew autocomplete in zsh; must be done before sourcing oh-my-zsh
if [[ $(uname) == "Darwin" ]] && [[ $(arch) == "arm64" ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

# configures tailscale autocomplete in zsh
autoload -U compinit; compinit
