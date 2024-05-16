#!/usr/bin/env zsh

obsidian_vaults="$HOME/obsidian-vaults"
obsidian_settings="$HOME/dotfiles/obsidian"

for vault in "$obsidian_vaults"/*; do
    vault_settings="$vault/.obsidian"
    echo "$vault_settings"

    if [[ -f "$vault_settings" ]] || [[ -L "$vault_settings" ]]; then
        # remove if file or symlink exists
        rm "$vault_settings"
    elif [[ -d "$vault_settings" ]]; then
        # remove if directory exists
        rm -r "$vault_settings"
    fi

    ln -s "$obsidian_settings" "$vault_settings"
    echo "Symlinked $obsidian_settings to $vault_settings"
done

echo "All vaults set up!"
