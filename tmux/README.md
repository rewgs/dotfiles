# Common commans
To reload/"source" tmux.conf: Prefix+Alt+r


# tpm
Location: $HOME/src/
prefix + I - downloads TPM plugins and reloads TMUX environment
prefix + U - updates a plugin (or all of them) and reloads TMUX environment
prefix + alt + u - remove unused TPM plugins and reloads TMUX environment

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

# Notes:

## Modifer Keys: 
- C- = Control
- S- = Shift
- M- = Alt ("Meta")

## Flags:
- -n = no prefix required
- -r = repeatable

# control codes
https://www.windmill.co.uk/ascii-control-codes.html
