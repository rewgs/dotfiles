if [[ "$(uname)" == "Linux" ]]; then
    if command -v hyprlock &> /dev/null; then
        alias lock="hyprlock --immediate"
    fi
fi
