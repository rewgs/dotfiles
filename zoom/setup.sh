#!/bin/bash
#
# Symlinks zoom `dots/zoomus.conf` file to ~/.config/zoomus.conf.

if [[ $(uname == "Linux") ]]; then
    dots="$(realpath $(dirname $BASH_SOURCE)/dots)"
    src="$dots/zoomus.conf"
    dst="$HOME/.config/zoomus.conf"
    
    # TODO: Check if $dst already exists.
    ln -s "$src" "$dst"
fi
