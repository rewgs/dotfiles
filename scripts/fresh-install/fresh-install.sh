#!/bin/sh


if [[ $(uname) == "Darwin" ]]; then
    echo "Running installations on macOS..."
    ./mac.sh    # note: this must be executable
elif [[ $(uname) == "Linux" ]]; then
    echo "Running installations on Linux..."
    ./linux.sh  # note: this must be executable
else
    echo "Unsupported operating system!"
fi
