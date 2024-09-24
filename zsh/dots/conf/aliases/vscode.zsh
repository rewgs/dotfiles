if [[ "$(uname)" == "Linux" ]]; then
    # Enables the `code .` command to open in Wayland when possible.
    # https://www.reddit.com/r/Fedora/comments/1afkoge/how_to_make_vscode_run_in_wayland_mode/
    alias code="code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto"
fi
