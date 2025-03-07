#!/bin/bash

_script="$(realpath "$BASH_SOURCE")"
_linux_dir="$(dirname "$_script")"
_scripts_dir="$(dirname "$_linux_dir")"
repo_root="$(dirname "$_scripts_dir")"
build_dir="$repo_root/build"
dst="$build_dir/linux/amd64"

if [[ ! -d "$dst" ]]; then
    mkdir -p "$dst"
fi

GOOS=linux GOARCH=amd64 go build -o "$dst/installs" "$repo_root"
