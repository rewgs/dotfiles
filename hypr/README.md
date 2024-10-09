`[hyprland.conf](./hyprland.conf)` is executed by the Hyprland binary. This file then executes all files listed within it.

Each machine has a directory named as its $HOSTNAME with files specific to it within it.

Files within [`common`](./common) are common to all machines -- they are symlinked to the $HOSTNAME directory. Files not symlinked are not seen by hyprland.conf and therefore not sourced.
