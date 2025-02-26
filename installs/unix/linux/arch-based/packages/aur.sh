#!/bin/bash

aur_helper="paru"

packages=(
    "1password"
    "cbonsai"
    "google-chrome-wayland-vulkan"
    "gotop-bin" # like htop, ytop, etc written in go; also gotop-bin available
    "hyprshot"  # screenshot utility for Hyprland
    "jetbrains-toolbox"
    "kanshi" # used for display configs in wayland window managers/desktop environments
    "kmonad-bin"
    "podman-desktop-bin"
    "powershell-bin"
    "selectdefaultapplication-fork-git" # Great little utility for editing ~/.config/mimeapps.list
    "slack-desktop-wayland"
    "sublime-text-4"
    "sublime-merge"
    "uhk-agent-appimage"
    "ungoogled-chromium-bin"
    "visual-studio-code-bin"
    "xdg-utils" # after this, run xdg-settings set default-web-browser google-chrome.desktop
    "zen-browser-bin"
)

function aur::main() {
    "$aur_helper" -Syu
    for package in "${packages[@]}"; do
        "$aur_helper" -Sy "$package" --noconfirm
    done
}
aur::main
