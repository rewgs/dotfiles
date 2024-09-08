This contains any and all dotfiles, configuration files, etc. Each tool contains its own `setup` script to symlink dotfiles/etc.

**shell:** zsh

**editor:** nvim

# Notes on window manager

## Linux

`hyprland` for the moment. Keeping it pretty simple.

## macOS 

I achieve tiling functionality and global key bindings Hammerspoon. It's relatively basic -- mostly key bindings for

I've tried `yabai`/`skhd` but I didn't click with them. Interested in trying out AeroSpace, though.

I use Bartender to clean up the Menu Bar, but might switch to [Ice](https://github.com/jordanbaird/Ice).

I use Rectangle with all key commands disabled so that mouse-driven, Windows-esque window snapping is available.

Previously, I used Karabiner-Elements to remap Caps Lock to "Hyper" (Command + Control) when held down, and Escape when tapped. However, this never worked *quite* perfectly -- for example, some apps will capture the Escape signal no matter what, sometimes cancelling out of focused windows. Ultimately there were too many edge cases bugging me, so I got rid of it.

Notes on using Karabiner-Elements to create a Hyper key:
- For this to work, System Settings/Keyboard/Keyboard Shortcuts/Modifier Keys/Caps Lock must NOT be remapped -- just leave it alone.
- Caps Lock is now enabled by taping both left and right Shift keys simultaneously. Code found [here](https://github.com/pqrs-org/Karabiner-Elements/issues/1233).
- Hyper was the primary modifier, a la Super/Windows Key.
- Hyper + Shift ("sHyper") was also available.
