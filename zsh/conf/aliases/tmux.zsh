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
