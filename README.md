This contains any and all dotfiles, configuration files, etc.

[`utils`](./utils) contains scripts for installing apps and packages, as well as symlinking dotfiles to their necessary locations.

**shell:** zsh

**editor:** nvim

**window manager:**
- Linux: sway, usually
- macOS: ad-hoc functionality and key bindings via Karabiner-Elements and Hammerspoon. I've tried `yabai`/`skhd` but I feel they're too invasive.
    - Karabiner-Elements handles remaps:
        - Caps Lock to "Hyper" (Command + Option + Control) when held down, and Escape when tapped. NOTE: For this to work, System Settings/Keyboard/Keyboard Shortcuts/Modifier Keys/Caps Lock must NOT be remapped -- just leave it alone.
        - Caps Lock is now enabled by taping both left and right Shift keys simultaneously. Code found [here](https://github.com/pqrs-org/Karabiner-Elements/issues/1233).
    - Hammerspoon handles window management:
        - Hyper is the primary modifier, a la Super/Windows Key.
        - Hyper + Shift ("sHyper") is also available.

# TODO
- Add `hammerspoons/Spoons` git submodule
