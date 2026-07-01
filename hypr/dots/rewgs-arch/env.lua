-- Cursor
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "24")

hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-- Theming
-- GTK_THEME forces dark mode for GTK3 apps via env; GTK4/libadwaita use gsettings
-- color-scheme (set in exec.lua on startup) instead.
hl.env("GTK_THEME", "Adwaita:dark")

-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Qt
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
