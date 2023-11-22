alias es="exec $SHELL && source_shell"

# aws
if [[ $(uname) == "Linux" ]]; then
    alias wasabi="aws s3 --profile wasabi"
    alias wsb="aws s3 --profile wasabi"
    alias s3="aws s3 --profile wasabi"
fi

# zshrc
alias z="$EDITOR $HOME/.zshrc"
alias sz="source $HOME/.zshrc"
alias ss="source_shell"

# common commands and functions
alias c="clear"
if [[ $(uname) == "Darwin" ]] || [[ $(uname) == "Linux" ]]; then
    alias ls=ls_improved
elif [[ $(uname) == "FreeBSD" ]]; then
    alias ls="ls -al"
fi
alias cls=clear_then_ls_improved
alias eh="echo 'You are using $HOST'"
alias mkd="mkdir"
alias mv="mv -i"       # prompts before overwriting already-existing file; TODO: make this take multiple arguments
alias rm=rmv         # aliasing rm to my custom function rmv; TODO: make this take multiple arguments
alias sdo=run_as_sudo

# neovim
alias v="nvim"
alias nvinit="$EDITOR $HOME/.config/nvim/init.lua"

# docker
if [[ $(uname) == "Linux" ]]; then
    alias dcls="docker container ls"
    alias ncst="docker start nextcloud-aio-mastercontainer"
    alias ncsp="docker stop nextcloud-aio-mastercontainer"
    alias rm_all_containers=remove_all_docker_containers
fi

# i3 config
if [[ $(uname) == "Linux" ]]; then
    alias i3c="$EDITOR $HOME/dotfiles/i3/config"
fi

# other editors
alias h="hx"    # helix
alias k="kak"   # kakoune
alias n="nano"  # nano

# broot
# TODO: fix this, not currently working
alias b="br" # invokes broot in power-user mode (br)

# git clients
alias g="git-graph"
alias gg="git-igitt"

# git commands
alias gap=git_add_all_and_push_with_commit_message_arg
alias gp="git pull"
alias gfarp="git fetch --all && git reset --hard && git pull"
alias grm=git_commit_readme

# linode cli
alias linhelp="linode-cli --help"
alias linlinhelp="linode-cli linodes --help"
alias createlinhelp="linode-cli linodes create --help"
alias linls="linode-cli linodes list"

# multipass
if [[ $(uname) == "Darwin" ]]; then
    alias mpls="multipass list"          # lists all multipass VMs
    alias mpsh="multipass shell ubuntu"  # starts and ssh's into main VM
    alias mpst="multipass start ubuntu"  # starts main VM but doesn't connect to it
    alias mpsp="multipass stop ubuntu"   # stops ubuntu VM
    alias snsmpsh="multipass shell sns"
    alias snsmpst="multipass start sns"
    alias snsmpsp="multipass stop sns"
fi

# OrbStack
if [[ $(uname) == "Darwin" ]]; then
    alias archvm="orb -m arch -u rewgs"
    alias ubuntuvm="orb -m ubuntu -u rewgs"
fi

# python
# typically should only be used in an activated venv
alias pipfreeze="pip freeze > requirements.txt"
alias pipinstallreqs="pip install -r requirements.txt"
alias pyserve="python3 -m http.server 8080"

# pyenv
alias av=activate_venv
alias dv="deactivate"
alias nv=create_new_venv
alias nvhb=create_new_venv_v3.9_with_gui_fix_for_mac

# rustup
alias rustbook="rustup docs --book"
alias rustdocs="rustup doc"

# sed
if [[ $(uname) == "Darwin" ]]; then
    alias sed="gsed"
fi

# ssh
alias dlssh=download_file_from_server_as_name

# tailscale
if [[ $(uname) == "Darwin" ]]; then
    alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

alias tshosts=tailscale_get_magic_dns_hostnames

# tar
# if [[ $(uname) == "Linux" ]]; then
#     alias untar="tar -xvzf"
# fi

# tmux
alias t=new_tmux_session_name_optional
alias tls="tmux list-session"
alias ta="tmux attach -t"
alias td="tmux detach"
alias tk="tmux kill-session -t"
alias tq="tmux detach && tmux list-sessions"
alias ts="tmux source-file ~/.tmux.conf"
# TODO: make this a function so it can take arguments -- this is just an idea
# alias tsw="tmux swap-window -s $1 -t $2"
# TODO: make these key commands via iTerm?
# alias tspu="tmux swap-pane -U" # if more than two, goes clockwise
# alias tspd="tmux swap-pane -D" # if more than two, goes counter-clockwise

# yabai/skhd
if [[ $(uname) == "Darwin" ]]; then
    alias yst="brew services start yabai && brew services start skhd"
    alias ysp="brew services stop yabai && brew services stop skhd"
    alias yr="brew services restart yabai && brew services restart skhd"
fi

# xplr
alias x="xplr"

# connections and computers
alias macmini="ssh rewgs@rewgs-mac-mini.local"
alias nas="ssh rewgs@rewgs-nas"

# dotfiles
alias dotfiles="cd $HOME/dotfiles/"
alias dots="cd $HOME/dotfiles/"
alias d="cd $HOME/dotfiles/"
alias dn="cd $HOME/dotfiles/nvim/"

# sns
alias work="cd $HOME/work/"
alias sns="cd $HOME/work/sns/"
alias snsd="cd $HOME/work/sns/development/"
alias snstodo="cd $HOME/work/sns/sns-to-do/ && nvim README.md"

# updates
alias up=update_packages
alias cup=update_packages_and_cargo
