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
alias 'rm'='rm -i'                      # requires that the user confirm deletion (files)
alias 'rm -r'='rm -ri'                  # requires that the user confirm deletion (directories)
alias 'c'='clear'
alias 'b'='br'                          # invokes broot in power-user mode (br)
alias 'z'='nvim $HOME/.zshrc'
alias 'sz'='source $HOME/.zshrc'

# editors
alias 'h'='hx'    # helix
alias 'k'='kak'   # kakoune
alias 'n'='nvim'  # neovim

# updates
case "$OSTYPE" in
  darwin*)
    alias 'up'='brew update && brew upgrade'
  ;;
  linux*)
    alias 'up'='sudo apt update && sudo apt upgrade -y'
  ;;
esac

# colors for ls
case "$OSTYPE" in
  linux*)
    alias 'ls'='ls -alh --color'        # --color is the flag on Linux
  ;;

  darwin*)
    alias 'ls'='ls -alhG'               # -G is the flag on macOS/BSD
  ;;
esac

# locations
case "$OSTYPE" in
  linux*)
    alias 'p'='cd /mnt/p'
    alias 'bear'='cd /mnt/p/sns/development'
  ;;
  darwin*)
    alias 'p'='cd $HOME/Work/'
    alias 'bear'='cd $HOME/Work/SNS/development/'
  ;;
esac


# pyenv
alias 'av'='source venv/bin/activate'   # activates a Python virtual environment. Only works if cwd is project root, and if the virtual environment is called venv.
alias 'dv'='deactivate'                 # deactivates a Python virtual environment. 

# multipass (macOS only)
case "$OSTYPE" in
  darwin*)
    alias 'mpls'='multipass list'          # lists all multipass VMs
    alias 'mpsh'='multipass shell ubuntu'  # starts and enters a shell
    alias 'mpst'='multipass start ubuntu'  # starts ubuntu VM but doesn't enter it
    alias 'mpsp'='multipass stop ubuntu'   # stops ubuntu VM
  ;;
esac

# =============================================================================
# Colors for ls command
# =============================================================================

# notes:
# LS_COLORS key value pairs are sep[arated by a colon. Each color has two or more parts.
# The .dir_colors file in $HOME defines the defaults.

# types:
# no            global default
# fi            normal file
# di            directory
# ln            symbolic link
# pi            named pipe
# do            door
# bd            block device
# cd            character device
# or            symbolic link to a non-existent file (i.e. "orphan")
# so            socket
# tw            directory that is stick and other-writable (+t,o+w)
# ow            directory that is other--writable (o+w) and not sticky
# st            directory with the sticky bit set (+t) and not other-writable
# ex            executable file
# mi            missing (non-existent file pointed to by a symbolic link [visible when you type ls -l])
# lc            opening terminal code ("leftcode")
# rc            closing terminal code ("rightcode")
# *.extension   specified by extension type, for eample *.mp3

# colors:
# 00    default color
# 01    bold
# 04    underlined
# 05    flashing text
# 07    reverse filed (i.e. exchange foreground and background color
# 08    concealed (i.e. invisible)

# 31    red
# 32    green
# 33    orange
# 34    blue
# 35    purple
# 36    cyan
# 37    grey
# 90    dark grey
# 91    light red
# 92    light green
# 93    yellow
# 94    light blue
# 95    light purple
# 96    turqoise
# 97    white

# 40    black background
# 41    red background
# 42    green background
# 43    orange background
# 44    blue background
# 45    purple background
# 46    cyan background
# 47    grey background
# 100   dark grey background
# 101   light red background
# 102   light green background
# 103   yellow background
# 104   light blue background
# 105   light purple background
# 106   turqoise background
# 107   white background

# example:
# di=0;34;40      directory; normal font, green; black background
# di=1;34;40      directory; bold font, green; black background

# note: white space matters here! Don't try and make this more readable...unfortunately it won't work
LS_COLORS='ow=01;93;40:ln=00;35;40:ex=00;31;40:*.mp3=00;32;40:*.wav=00;32;40:*.aif=00;32;40:*.aiff=00;32;40'
export LS_COLORS


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


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

