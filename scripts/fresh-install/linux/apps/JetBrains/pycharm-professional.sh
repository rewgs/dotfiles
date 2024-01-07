#!/usr/bin/env zsh

web="https://download.jetbrains.com"
pro="python"
src="pycharm-professional-2023.3.2-aarch64.tar.gz"
url="$web/$pro/$src"

out="$HOME/pycharm-pro.tar.gz"
dst="$HOME/opt/JetBrains/"

wget "$url" -O "$out"

if [ ! -d "$dst" ]; then 
    mkdir -p "$dst"
fi

sudo tar -xzf "$out" -C "$dst"

rm -f "$out"
