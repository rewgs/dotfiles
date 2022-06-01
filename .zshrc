# =============================================================================
# Basics
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"             # Path to your oh-my-zsh installation.
ZSH_THEME="robbyrussell"                  # theme
source $ZSH/oh-my-zsh.sh

# CASE_SENSITIVE="true"                   # Uncomment to use case-sensitive completion.
# HYPHEN_INSENSITIVE="true"               # Uncomment to use hyphen-insensitive completion. Case-sensitive completion must be off. _ and - will be interchangeable.
# DISABLE_AUTO_UPDATE="true"              # Uncomment to disable bi-weekly auto-update checks.
# DISABLE_UPDATE_PROMPT="true"            # Uncomment to automatically update without prompting.
# export UPDATE_ZSH_DAYS=13               # Uncomment to change how often to auto-update (in days).
# DISABLE_MAGIC_FUNCTIONS="true"          # Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_LS_COLORS="true"                # Uncomment the following line to disable colors in ls.
# DISABLE_AUTO_TITLE="true"               # Uncomment the following line to disable auto-setting terminal title.
# ENABLE_CORRECTION="true"                # Uncomment the following line to enable command auto-correction.
# COMPLETION_WAITING_DOTS="true"          # Uncomment the following line to display red dots whilst waiting for completion. Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work). See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# DISABLE_UNTRACKED_FILES_DIRTY="true"    # Uncomment the following line if you want to disable marking untracked files under VCS as dirty. This makes repository status check for large repositories much, much faster.
# HIST_STAMPS="mm/dd/yyyy"                # Uncomment the following line if you want to change the command execution time stamp shown in the history command output. You can set one of the optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd" or set a custom format using the strftime function format specifications, see 'man strftime' for details.
# ZSH_CUSTOM=/path/to/new-custom-folder   # Uncomment to use another custom folder than $ZSH/custom?



# =============================================================================
# Plugins
# =============================================================================
# Standard plugins location:  $ZSH/plugins/
# Custom plugins location:    $ZSH_CUSTOM/plugins/
plugins=(git)



# =============================================================================
# Aliases
# =============================================================================

# basic commands
alias 'up'='sudo apt update && sudo apt upgrade -y'
alias 'ls'='ls -al'
alias 'rm'='rm -i'                      # requires that the user confirm deletion (files)
alias 'rm -r'='rm -ri'                  # requires that the user confirm deletion (directories)
alias 'c'='clear'
alias 'b'='br'                          # invokes broot in power-user mode (br)

# locations
alias 'p'='cd /mnt/p'
alias 'bear'='cd /mnt/p/sns/development'

# pyenv
alias 'av'='source venv/bin/activate'   # activates a Python virtual environment. Only works if cwd is project root, and if the virtual environment is called venv.
alias 'dv'='deactivate'                 # deactivates a Python virtual environment. 



# =============================================================================
# Colors (for Windows Terminal, I believe)
# =============================================================================
LS_COLORS='ow=01;36;40' ; export LS_COLORS



# =============================================================================
# PATH additions
# =============================================================================

# commands for all operating systems

# user bin folders
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# commands specific to certain operating systems
case "$OSTYPE" in
  # --------- Linux-specific ----------
  linux*)

    # ------------- PyEnv -------------
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
    fi
    export PYENV_ROOT="$HOME/src/pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

  ;;

  # --------- macOS-specific ----------
  darwin*)

    # ----------- HomeBrew ------------
    export PATH="/opt/homebrew/sbin:$PATH"
    export PATH="/opt/homebrew/cellar:$PATH"
    
    # ------------- Poetry ------------
    export PATH="$HOME/.poetry/bin:$PATH"


    # ------------- PyEnv -------------
    # Fixing the Homebrew $PATH directory
    export PATH=/opt/homebrew/bin:$PATH
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi

    # Adding PyEnv to $PATH
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
    plugin=(
      pyenv
    )

    # Not sure why this is here...is this redundant?
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

  ;;
esac

