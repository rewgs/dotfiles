if [ "$(uname)" = "Linux" ]; then
    if command -v hyprlock > /dev/null 2>&1; then
        alias lock="hyprlock --immediate"
    fi
fi
