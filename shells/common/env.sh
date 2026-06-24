OS_NAME="$(uname)"
export OS_NAME

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export HISTSIZE=10000

export EDITOR='nvim'

# browser
if [ "$OS_NAME" = "Linux" ]; then
    if command -v firefox > /dev/null 2>&1; then
        export BROWSER="$(command -v firefox)"
    fi
elif [ "$OS_NAME" = "Darwin" ]; then
    if [ -x "/Applications/Firefox.app/Contents/MacOS/firefox" ]; then
        export BROWSER="/Applications/Firefox.app/Contents/MacOS/firefox"
    fi
fi

# wayland
if [ "$OS_NAME" = "Linux" ]; then
    export ELECTRON_OZONE_PLATFORM_HINT="auto"
fi

# PATH

export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# broot
if [ -d "$XDG_CONFIG_HOME/broot" ]; then
    export PATH="$XDG_CONFIG_HOME/broot/launcher/bash:$PATH"
fi

# flutter
export PATH="$HOME/src/flutter/bin:$PATH"

# golang
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# jetbrains
if [ "$OS_NAME" = "Darwin" ]; then
    export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
elif [ "$OS_NAME" = "Linux" ]; then
    export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
fi

# nim
export PATH="$PATH:$HOME/.nimble/bin"

# nix
if [ -d "$HOME/.nix-profile/bin" ]; then
    export PATH="$PATH:$HOME/.nix-profile/bin"
fi

# poetry
if [ -d "$HOME/.poetry" ] || [ -L "$HOME/.poetry" ]; then
    export PATH="$PATH:$HOME/.poetry/bin"
fi

# reaper (Linux)
if [ "$OS_NAME" = "Linux" ]; then
    export PATH="$HOME/opt/REAPER:$PATH"
fi

# volta
if [ -d "$HOME/.volta" ]; then
    export VOLTA_HOME="$HOME/.volta"
    export PATH="$VOLTA_HOME/bin:$PATH"
    export VOLTA_FEATURE_PNPM=1
fi

# rust/cargo
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
