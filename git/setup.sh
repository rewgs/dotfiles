#!/bin/bash


_THIS_DIR="$(realpath $(dirname "$BASH_SOURCE"))"
# echo "$_THIS_DIR"


# TODO: put this in libbash, source it into this file
symlink_dotfile() {
    # TODO: finish
    # check_response() {
    #     local response="$1"
    #     local valid_response=(  "yes", "Yes", "YES", "y", 
    #                             "no", "No", "NO", "n" )
    #     if ! [[ "${array[@]}" =~ "$response" ]]; then
    #         read - "${response} is not a valid response. Try again."
    #         check_response
    #     fi
    # }

    local SRC="$1"
    local DST="$2"

    if [[ -L "$DST" ]]; then rm -f "$DST"; fi

    # TODO: finish when check_response() is finished. 
    # For now, the following `if` will just forcefully delete the file, as 
    # that's probably what I'll want to do in 90% of cases.
    # if [[ -f "$DST" ]]; then 
    #     read -p "$DST already exists. Do you want to overwrite it?" response
    #     check_response "$response"
    # fi
    if [[ -f "$DST" ]]; then rm -f "$DST"; fi

    if [[ ! -L "$DST" ]] || [[ ! -f "$DST" ]]; then
        ln -s "$SRC" "$DST"
    fi
}

symlink_config() {

    local SRC="$(realpath "$_THIS_DIR/config")"
    local DST="$HOME/.gitconfig/.gitconfig"

    symlink_dotfile "$SRC" "$DST"
}

symlink_ignore() {
    local SRC="$(realpath "$_THIS_DIR/ignore")"
    local DST="$HOME/.config/git/ignore"
    symlink_dotfile "$SRC" "$DST"
}

main() {
    symlink_config
    symlink_ignore
}
