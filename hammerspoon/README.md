# Installing

Unlike most dotfiles in this repo, the `hammerspoon` directory isn't symlinked to where Hammerspoon is looking for it (`~/.hammerspoon`). Instead, the `~/.hammerspoon` directory is a real directory, and all the files within `$DOTFILES/hammerspoon/hs-config` are symlinked to it. This is done because the `Spoons` directory of the [Spoons](https://github.com/Hammerspoon/Spoons/) repo needs to be symlinked to it as well, and I don't really want to git submodule it, so this is simpler in my mind.

The `setup.sh` script takes care of all of the above symlinking.

# Notes

- Hyper (i.e. Command + Control + Option) is defined via Karabiner-Elements. Caps Lock is mapped to Hyper when held down, Escape when tapped.
- Unlike 
- `Spoons/` is a symlink to the git cloned [repo](https://github.com/Hammerspoon/Spoons) `~/Spoons/Spoons`, in which all `.spoon.zip` files have been unzipped. Otherwise, I'd have to manually point to the Spoons like so:

``` lua
-- Look for Spoons in ~/.hammerspoon/MySpoons as well
package.path = package.path .. ";" ..  hs.configdir .. "/MySpoons/?.spoon/init.lua"
```

More info [here](https://github.com/Hammerspoon/hammerspoon/blob/master/SPOONS.md#loading-a-spoon).

# TODO

Rename hs-config to hammerspoon. Needlessly complicated.

window management:
- fancyzones-like visual grids
    - define grids with lua; `hyper+[something]` calls it
    - `hyper+g`: shows grid overlay
    - `hyper+s`: snaps all open windows to closest grid square

app remapping - replace BetterTouchTool
- VS Code: Remap `cmd+h` to `cmd+opt+ctrl+h`
- PyCharm: Remap `cmd+h` to `cmd+opt+ctrl+shift+h`
- Sublime Text: Remap `cmd+h` to `cmd+opt+ctrl+shift+h`
- Firefox: 
    - `opt+tab` to `opt+ctrl+j`
    - `opt+shift+tab` to `opt+ctrl+k`
- Reaper:
    - `ctrl+0` to `cmd+opt+ctrl+0`
    - `ctrl+1` to `cmd+opt+ctrl+1`
    - `ctrl+2` to `cmd+opt+ctrl+2`
    - `ctrl+3` to `cmd+opt+ctrl+3`
    - `ctrl+4` to `cmd+opt+ctrl+4`
    - `ctrl+5` to `cmd+opt+ctrl+5`
    - `ctrl+6` to `cmd+opt+ctrl+6`
    - `ctrl+7` to `cmd+opt+ctrl+7`
    - `ctrl+8` to `cmd+opt+ctrl+8`
    - `ctrl+9` to `cmd+opt+ctrl+9`
    - `cmd+h` to `cmd+opt+ctrl+h`
- any terminal: `cmd` = tmux prefix

# references
- https://github.com/NateEag/dotfiles/blob/d8c81c3890af65bf4316718426d88e13398e6eaa/src/.hammerspoon/init.lua
