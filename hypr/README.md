`[hyprland.conf](./hyprland.conf)` is executed by the Hyprland binary. This file then executes all files listed within it.

Each machine has a directory named as its $HOSTNAME with files specific to it within it.

Files within [`common`](./common) are common to all machines -- they are symlinked to the $HOSTNAME directory. Files not symlinked are not seen by hyprland.conf and therefore not sourced.

## Required packages

### Cursor theme (macOS-style, black with white outline)

| Package | Provides | Used by |
| --- | --- | --- |
| `apple_cursor` (AUR) | XCursor themes `macOS`, `macOS-White` | XWayland / GTK apps (`XCURSOR_THEME`) |
| `apple_hyprcursor` (AUR) | hyprcursor themes `macOS-hypr`, `macOS-hypr_white` | native Wayland clients (`HYPRCURSOR_THEME`); scales to any size |
| `hyprcursor` | hyprcursor runtime library | Hyprland, to load hyprcursor themes |

Install with an AUR helper, e.g.:

```sh
paru -S --needed apple_cursor apple_hyprcursor hyprcursor
```

Both `apple_cursor` and `apple_hyprcursor` are the same theme in two formats -- install
both so native and XWayland apps match. Configured in `<hostname>/env.lua` (theme + size
env vars) and `<hostname>/exec.lua` (`gsettings` + `hyprctl setcursor` on startup).

Notes:
- Cursor size is set in three places that must agree: `env.lua`, `xwayland.lua`, and the
  `gsettings` / `hyprctl setcursor` calls in `exec.lua`.
- `WLR_NO_HARDWARE_CURSORS` does nothing on modern Hyprland (wlroots-era); use the
  `cursor:no_hardware_cursors` option if hardware cursors ever need disabling.
