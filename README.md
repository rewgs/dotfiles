This contains any and all dotfiles, configuration files, etc.

`scripts/` contains scripts for installing apps and packages, as well as symlinking dotfiles to their necessary locations.

shell: zsh

editor: nvim

window manager:
- Linux: sway, usually
- macOS: ad-hoc functionality and key bindings via Karabiner-Elements and Hammerspoon:
    - Karabiner-Elements remaps:
        - Caps Lock to "Hyper" (Command + Control) when held down, and Escape when tapped.
            - NOTE: For this to work, System Settings/Keyboard/Keyboard Shortcuts/Modifier Keys/Caps Lock must NOT be remapped -- just leave it alone.
            - For this to feel good, Karabiner-Elements/Settings/Parameters are set to:
                - to_if_alone_milliseconds: 200
                - to_if_held_down_milliseconds: 100
                - to_delayed_action_milliseconds: 100
                - simultaneous_threshold_milliseconds: 40
                - These should all be saved in the config file, but noting here just in case.
        - Escape to Caps Lock
    - Hammerspoon handles window management. Hyper is the primary modifier, but Hyper + Option ("oHyper"), Hyper + Shift ("sHyper"), and Hyper + Option + Shift ("soHyper") are also available.
