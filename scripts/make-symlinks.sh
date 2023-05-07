#!/bin/bash

# TODO: make sure this works! I took this from Linux and haven't yet run this on macOS.

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ make directories                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if [[ ! -d $HOME/.config ]]; then
    mkdir $HOME/.config
fi

if [[ ! -d $HOME/.tmux/plugins ]]; then
    mkdir -p $HOME/.tmux/plugins
fi

if [[ ! -d $HOME/dotfile_backups/bash ]]; then
    mkdir -p $HOME/dotfile_backups/bash
fi

if [[ ! -d $HOME/dotfile_backups/nvim ]]; then
    mkdir -p $HOME/dotfile_backups/nvim
fi

if [[ ! -d $HOME/dotfile_backups/sh ]]; then
    mkdir -p $HOME/dotfile_backups/sh
fi

if [[ ! -d $HOME/dotfile_backups/tmux ]]; then
    mkdir -p $HOME/dotfile_backups/tmux
fi

if [[ ! -d $HOME/dotfile_backups/zsh ]]; then
    mkdir -p $HOME/dotfile_backups/zsh
fi

if [[ ! -d "$HOME/src" ]];  then
    mkdir "$HOME/src"
fi


# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ backup old dotfiles and create symlinks to my dotfiles                     ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# bash
if [[ -f $HOME/.bashrc ]]; then
    mv $HOME/.bashrc $HOME/dotfile_backups/bashrc
    ln -s $HOME/dotfiles/bash/bashrc $HOME/.bashrc
elif [[ -h $HOME/.bashrc ]]; then
    rm $HOME/.bashrc
    ln -s $HOME/dotfiles/bash/bashrc $HOME/.bashrc
else
    ln -s $HOME/dotfiles/bash/bashrc $HOME/.bashrc
fi

if [[ -f $HOME/.bash_profile ]]; then
    mv $HOME/.bash_profile $HOME/dotfile_backups/bash_profile
    ln -s $HOME/dotfiles/bash/bash_profile $HOME/.bash_profile
elif [[ -h $HOME/.bash_profile ]]; then
    rm $HOME/.bash_profile
    ln -s $HOME/dotfiles/bash/bash_profile $HOME/.bash_profile
else
    ln -s $HOME/dotfiles/bash/bash_profile $HOME/.bash_profile
fi

# nvim
# TODO: packer
if [[ -d $HOME/.config/nvim ]]; then
    mv $HOME/.config/nvim $HOME/dotfile_backups/nvim
    ln -s $HOME/dotfiles/nvim/ $HOME/.config/nvim
elif [[ -h $HOME/.config/nvim ]]; then
    rm $HOME/.config/nvim/
    ln -s $HOME/dotfiles/nvim/ $HOME/.config/nvim
else
    ln -s $HOME/dotfiles/nvim/ $HOME/.config/nvim
fi

# sh
if [[ -f $HOME/.profile ]]; then
    mv $HOME/.profile $HOME/dotfile_backups/sh/
    ln -s $HOME/dotfiles/sh/profile $HOME/.profile
elif [[ -h $HOME/.profile ]]; then
    rm $HOME/.profile
    ln -s $HOME/dotfiles/sh/profile $HOME/.profile
else
    ln -s $HOME/dotfiles/sh/profile $HOME/.profile
fi

# tmux
if [[ -f $HOME/.tmux.conf ]]; then
    mv $HOME/.tmux.conf $HOME/dotfile_backups/tmux/
    ln -s $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf
elif [[ -h $HOME/.tmux.conf ]]; then
    rm $HOME/.tmux.conf
    ln -s $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf
else
    ln -s $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf
fi
 
if [[ ! -d $HOME/src/tpm ]]; then
    git clone git@github.com:tmux-plugins/tpm.git $HOME/src
    ln -s $HOME/src/tpm/ $HOME/.tmux/plugins/tpm
elif [[ -h $HOME/.tmux/plugins/tpm ]]; then
    rm $HOME/.tmux/plugins/tpm
    ln -s $HOME/src/tpm/ $HOME/.tmux/plugins/tpm
else
    ln -s $HOME/src/tpm/ $HOME/.tmux/plugins/tpm
fi


# zsh
if [[ -f $HOME/.zshenv ]]; then
    mv $HOME/.zshenv $HOME/dotfile_backups/zsh/
    ln -s $HOME/dotfiles/zsh/zshenv $HOME/.zshenv
elif [[ -h $HOME/.zshenv ]]; then
    rm $HOME/.zshenv
    ln -s $HOME/dotfiles/zsh/zshenv $HOME/.zshenv
else
    ln -s $HOME/dotfiles/zsh/zshenv $HOME/.zshenv
fi

if [[ -f $HOME/.zprofile ]]; then
    mv $HOME/.zprofile $HOME/dotfile_backups/zsh/
    ln -s $HOME/dotfiles/zsh/zprofile $HOME/.zprofile
elif [[ -h $HOME/.zprofile ]]; then
    rm $HOME/.zprofile
    ln -s $HOME/dotfiles/zsh/zprofile $HOME/.zprofile
else
    ln -s $HOME/dotfiles/zsh/zprofile $HOME/.zprofile
fi

if [[ -f $HOME/.zshrc ]]; then
    mv $HOME/.zshrc $HOME/dotfile_backups/zsh/
    ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
elif [[ -h $HOME/.zshrc ]]; then
    rm $HOME/.zshrc
    ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
else
    ln -s $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
fi

if [[ -f $HOME/.zlogin ]]; then
    mv $HOME/.zlogin $HOME/dotfile_backups/zsh/
    ln -s $HOME/dotfiles/zsh/zlogin $HOME/.zlogin
elif [[ -h $HOME/.zlogin ]]; then
    rm $HOME/.zlogin
    ln -s $HOME/dotfiles/zsh/zlogin $HOME/.zlogin
else
    ln -s $HOME/dotfiles/zsh/zlogin $HOME/.zlogin
fi

if [[ -f $HOME/.zlogout ]]; then
    mv $HOME/.zlogout $HOME/dotfile_backups/zsh/
    ln -s $HOME/dotfiles/zsh/zlogout $HOME/.zlogout
elif [[ -h $HOME/.zlogout ]]; then
    rm $HOME/.zlogout
    ln -s $HOME/dotfiles/zsh/zlogout $HOME/.zlogout
else
    ln -s $HOME/dotfiles/zsh/zlogout $HOME/.zlogout
fi
