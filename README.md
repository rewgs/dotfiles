# dotfiles

This repo contains any and all dotfiles, configuration files, etc.

Each application follows a similar structure:

```
dotfiles
└── app
    ├── dots        -> The app's actual dotfiles/config files/etc.
    ├── README.md   -> Useful for
    └── setup.sh    -> Symlinks dotfiles to where they need to be; usually ~/.config/${appName}.
```

Most `dots` directories are flat, but some are more complicated. For example, I've set up [`neovim`](./nvim) to choose its dotfiles by the current machine's `$HOST`.

**shell:** [zsh](./zsh)

**editor:** [neovim](./nvim)

### Linux

- **Window manager:** [`hyprland`](./hypr). It's the best I've ever used by a mile.
- **Bar:** [`waybar`](./waybar). Pretty good, might move to `eww`.
- I'm using `hyprlock` and `hypridle` for screen lock and sleep, respectively, as well as `kanshi` for dynamically turning on/off my laptop display on my Thinkpad X1 Carbon when plugging into my 4k display (I like using one display, no more, no less). Unfortunately turning _off_ the external display causes...something to crash (not sure if the problem lies with `kanshi`, `hyprlock`, or `hyprland` itself), resulting in the Wayland "red screen of death," so that's fun. For now, I'm just careful, I guess.

### macOS

- **Window manager:** I achieve tiling functionality via [Phoenix](./phoenix). I tried [`yabai`](./yabai)/[`skhd`](./skhd), [`Aerospace`](./aerospace), etc, but I didn't click with them -- they all feel "tacked on," nowhere near as smooth as a native tiling window manager on Linux. Global key bindings are configured via [Hammerspoon](./hammerspoon). I used to use it for window tiling as well, but it doesn't handle snapping non-native apps as well as Phoenix. I use Rectangle with all key commands disabled so that mouse-driven, Windows-esque window snapping is available when needed. Previously, I used Karabiner-Elements to remap Caps Lock to "Hyper" (Command + Control) when held down, and Escape when tapped. However, this never worked _quite_ perfectly -- for example, some apps will capture the Escape signal no matter what, sometimes cancelling out of focused windows. Ultimately there were too many edge cases bugging me, so I got rid of it, but my [config](./karabiner/) is still available for those interested.
- **Bar:** I use Bartender to clean up the Menu Bar, but might switch to [Ice](https://github.com/jordanbaird/Ice).
- I use [Contexts](https://contexts.co/) in place of `Cmd+Tab`; this is, unfortunately, not configured via dotfiles, but it's a great app so it's worth mentioning.

### Windows

- [`./komorebi`] is handling the tiling window management and bar. My setup is very close to stock.

<!--
TODO:
- Share environment variables, aliases, etc between shells. Sources:
    - https://unix.stackexchange.com/questions/3428/share-aliases-and-path-setting-between-zsh-and-bash
    - https://stackoverflow.com/questions/34565843/how-can-zsh-and-normal-shell-share-environment-variables-and-aliases-without-cop
-->
