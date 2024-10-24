# dotfiles

This repo contains any and all dotfiles, configuration files, etc. Each tool contains its own `setup` script to symlink dotfiles/etc.

<!-- 
TODO: Share environment variables, aliases, etc between shells. 
Sources: 
https://unix.stackexchange.com/questions/3428/share-aliases-and-path-setting-between-zsh-and-bash
https://stackoverflow.com/questions/34565843/how-can-zsh-and-normal-shell-share-environment-variables-and-aliases-without-cop
-->
**shell:** [zsh](./zsh)

**editor:** [neovim](./nvim)

## Notes on GUI utilities

### Linux

- window manager: [`hyprland`](./hypr). It's the best I've ever used by a mile.
- bar: [`waybar`](./waybar). Pretty good, might move to `eww`.
- using `hyprlock` and `hypridle` for screen lock and sleep, respectively, as well as `kanshi` for dynamically turning on/off my laptop display on my Thinkpad X1 Carbon when plugging into my 4k display (I like using one display, no more, no less). Unfortunately turning *off* the external display causes...something to crash (not sure if the problem lies with `kanshi`, `hyprlock`, or `hyprland` itself), resulting in the Wayland "red screen of death," so that's fun. For now, I'm just careful, I guess.

### macOS 

I achieve tiling functionality via [Phoenix](./phoenix).

Global key bindings are configured via [Hammerspoon](./hammerspoon). I used to use it for window tiling as well, but wanted to give Phoenix a spin, as I prefer writing JavaScript over Lua (though, honestly, I don't really like either language). That said, I may switch back to using Hammerspoon for tiling again, as Phoenix has a few rough edges, and generally I'd prefer to use one tool over two.

I've tried [`yabai`](./yabai) and [`skhd`](./skhd) but I didn't click with them. I may try out AeroSpace, though.

I use Bartender to clean up the Menu Bar, but might switch to [Ice](https://github.com/jordanbaird/Ice).

I use Rectangle with all key commands disabled so that mouse-driven, Windows-esque window snapping is available when needed.

Previously, I used Karabiner-Elements to remap Caps Lock to "Hyper" (Command + Control) when held down, and Escape when tapped. However, this never worked *quite* perfectly -- for example, some apps will capture the Escape signal no matter what, sometimes cancelling out of focused windows. Ultimately there were too many edge cases bugging me, so I got rid of it, but my [config](./karabiner/) is still available for those interested.
