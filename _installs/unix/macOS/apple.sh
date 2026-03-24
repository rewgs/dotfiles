#!/bin/bash


install_xcode_command_line_tools() {
    xcode-select --install
}


install_from_app_store() {
    apps=(
        "Adblock Plus"
        "BetterSnapTool"
        "Bitwarden"
        "Developer"
        "Keynote"
        "LanScan"
        "Logic Pro"
        "Microsoft Remote Desktop"
        "Numbers"
        "Pages"
        "Slack"
        "Tailscale"
        "The Unarchiver"
        "UTM"
        "Vimari"
        "WhatsApp"
        "Xcode"
    )
    for (( i = 1; i <= $#apps; i++)) do
        app_id=$(mas search "$apps[i]")
        mas install "$app_id"
    done
}
