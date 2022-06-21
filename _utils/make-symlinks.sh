#!/bin/bash

# helix
ln -s $HOME/dotfiles/helix/ $HOME/.config/helix
ln -s $HOME/src/helix/runtime/ $HOME/dotfiles/helix/runtime

# nvim
ln -s $HOME/dotfiles/nvim/ $HOME/.config/nvim

# tmux
ln -s $HOME/dotfiles/tmux/tmux.confg $HOME/.tmux.conf
ln -s $HOME/src/tpm/ $HOME/dotfiles/tmux/tpm

# zsh
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc