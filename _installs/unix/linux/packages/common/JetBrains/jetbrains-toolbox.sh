#!/usr/bin/env zsh

# NOTE: toolbox does not work on Linux ARM.
#
web="https://download.jetbrains.com"
pro="toolbox"
src="jetbrains-toolbox-2.1.3.18901.tar.gz"

out="$HOME/jt.tar.gz"
dst="$HOME/opt/JetBrains/"

wget "$url" -O "$out"

if [ ! -d "$dst" ]; then 
    mkdir -p "$dst"
fi

sudo tar -xzf "$out" -C "$dst"

rm -f "$out"
