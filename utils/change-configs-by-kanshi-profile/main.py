#!/usr/bin/env python3
#
# Runs via `exec` command in kanshi config: https://man.archlinux.org/man/kanshi.5.en
#
# This is primarily for improving font sizes for a given kanshi profile;
# e.g. font should be smaller when on laptop display, but larger when on Apple Pro Display XDR

import os
import sys
from pathlib import Path
from socket import gethostname

from app import App

from kanshi import Kanshi


def __get_env_var_path(env_var: str) -> Path:
    path: str | None = os.getenv(env_var)
    if path is None:
        raise FileNotFoundError
    try:
        resolved: Path = Path(path).resolve(strict=True)
    except FileNotFoundError as error:
        raise error
    return resolved


# This will only work with my zsh config, as this environment variable is defined in my .zshenv file.
DOTFILES: Path = __get_env_var_path("DOTFILES")
CONFIG: Path = __get_env_var_path("XDG_CONFIG_HOME")

to_config: tuple[App, ...] = (
    App(
        name="fuzzel",
        src=DOTFILES.joinpath("fuzzel", "dots"),
        dst=CONFIG.joinpath("fuzzel", "fuzzel.ini"),
    ),
    App(
        name="hyprland",
        src=DOTFILES.joinpath("hypr", "dots"),
        dst=DOTFILES.joinpath("hypr", "dots", gethostname()),
    ),
    App(
        name="waybar",
        src=DOTFILES.joinpath("waybar", "dots", "hyprland"),
        dst=CONFIG.joinpath("waybar"),
    ),
    App(
        name="wezterm",
        src=DOTFILES.joinpath("wezterm", "dots"),
        dst=DOTFILES.joinpath("wezterm", "dots", gethostname()),
    ),
)


def main(kanshi_profile: str):
    for app in to_config:
        app.change_config(kanshi_profile)


if __name__ == "__main__":
    try:
        main(sys.argv[1])
    except IndexError as error:
        print("One Kanshi profile name is required!\n")
        raise error
