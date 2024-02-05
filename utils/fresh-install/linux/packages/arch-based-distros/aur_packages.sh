#!/bin/bash

declare -a packages 
packages=(
    "cbonsai"
    "kmonad-bin"
    "slack-desktop"
    "uhk-agent-appimage"
    "visual-studio-code-bin"
    "xdg-utils" # after this, run xdg-settings set default-web-browser google-chrome.desktop
)

