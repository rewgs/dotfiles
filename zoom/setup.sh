#!/bin/bash
#
# Symlinks zoom `dots/zoomus.conf` file to ~/.config/zoomus.conf.

dots="$(realpath $(dirname $BASH_SOURCE)/dots)"
src="$dots/zoomus.conf"
dst="$HOME/.config/zoomus.conf"

# TODO: Check if $dst already exists.
ln -s "$src" "$dst"
