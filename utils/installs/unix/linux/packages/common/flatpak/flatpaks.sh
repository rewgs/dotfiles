#!/bin/bash

flatpaks=(
    "protonvpn"
)

for f in "${flatpaks[@]}"; do
    flatpak install flathub "com.${f}.www"

    # NOTE: To run:
    # `flatpak run "com.${f}.www"`
done

