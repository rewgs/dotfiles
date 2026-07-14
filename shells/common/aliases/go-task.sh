if ! command -v task > /dev/null 2>&1; then
    if command -v go-task > /dev/null 2>&1; then
        alias task="go-task"
    fi
fi
