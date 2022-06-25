#!/bin/bash

# About this file:
#
# This repo contains a directory at its root called ""_links".
# In it is a link that, for simplicity (and my sanity's sake), must exist in the dotfiles repo.
# It must be generated anew upon each pull (unless it's coming from the same machine (or maybe Os) but both cases are unlikely). 
# So I'm just treating every pull as a pure destroy and re-pull.
# Therefore the links must be generated every time the git repo is pulled.
#
# The folder structure is currently as follows:
#
#  /dotfiles
#    /_links
#    /_utils
#    helix
#    kakoune
#    nano
#    nvim
#    tmux
