# Common commans
To install tpm plugins: Prefix+I
To reload/"source" tmux.conf: Prefix+Alt+r


# tpm
Location: $HOME/src/

Requires the following symbolic links:
- ln -s $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf
- ln -s $HOME/src/tpm/ $HOME/.tmux/plugins/tpm
- ln -s $HOME/src/tpm/ $HOME/tpm


# Prefix and the Super/Windows/Command key with iTerm2:
- The prefix key is Control+p (or, in tmux speak, C-p).
- The hex code for C-p is 10.
- e.g. to send prefix + h:
    - The iTerm2 key command is Command+h.
    - This sends the key code 10 68, or Control+p h.
    - Therefore, the Command key is essentially the tmux prefix.
