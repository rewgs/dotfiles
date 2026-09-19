# yazi

## wav files not opening in VLC (2026-08-25)

Pressing Enter on a `.wav` file in yazi opened VLC but never loaded the file.

Two separate bugs were involved:

1. **`dots/yazi.toml` used the wrong `run` placeholder syntax.** The opener was
   written as `run = 'vlc "$@"'`, which is old/ranger-style shell-argv-append
   syntax. This yazi version (26.8.15) only substitutes its documented
   placeholders (`%s`, `%S`, `%sN`, `%SN`, `%d`, `%D`, `%dN`, `%DN`, `%%`) into
   `run` — it does not auto-append selected files as positional shell args, so
   `$@` was always empty. Fixed by changing it to `run = 'vlc %s'`.

2. **A broken system-wide desktop entry.** `~/.local/share/applications/vlc-2.desktop`
   was a stale, auto-generated entry (likely created by a GTK "Open With..."
   dialog) with `Exec=/usr/bin/vlc` and no `%f`/`%U`. It was registered in
   `~/.config/mimeapps.list` as the default handler for `audio/vnd.wave`, so
   any app that fell back to the xdg default for wav files (e.g. `xdg-open`,
   double-click in a GUI file manager) would also launch VLC with no file.
   This was unrelated to yazi's own opener resolution but was fixed anyway:
   removed the desktop file and its `mimeapps.list` entries. The system
   default for wav now correctly resolves to `mpv.desktop`.

Mime detection itself was never the problem — yazi shells out to
`file -bL --mime-type` (confirmed via `ya env`), which correctly identifies
real production wav files (including ones with `JUNK`/`bext` broadcast-wave
chunks) as `audio/x-wav`, matching the `audio/*` rule in `[open].rules`.
