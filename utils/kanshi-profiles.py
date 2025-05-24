#!/usr/bin/env python3
#
# Runs via `exec` command in kanshi config: https://man.archlinux.org/man/kanshi.5.en
#
# This is primarily for improving font sizes for a given kanshi profile;
# e.g. font should be smaller when on laptop display, but larger when on Apple Pro Display XDR

# class KanshiProfile:

import os
import sys
from pathlib import Path


class App:
    """An application configured via dotfiles."""

    def __init__(self, name: str, src: Path, dst: Path):
        self.name: str = name
        self.src: Path = src
        self.dst: Path = dst


def get_env_var_path(env_var: str) -> Path:
    path: str | None = os.getenv(env_var)
    if path is None:
        raise FileNotFoundError
    try:
        resolved: Path = Path(path).resolve(strict=True)
    except FileNotFoundError as error:
        raise error
    return resolved


def main(kanshi_profile: str):
    # This will only work with my zsh config, as this environment variable is defined in my .zshenv file.
    dotfiles: Path = get_env_var_path("DOTFILES")
    config: Path = get_env_var_path("XDG_CONFIG_HOME")

    apps: list[App] = [
        App(
            name="fuzzel",
            src=dotfiles.joinpath("fuzzel", "dots"),
            dst=config.joinpath("fuzzel"),
        ),
        App(
            name="hyprland",
            src=dotfiles.joinpath("hypr", "dots"),
            dst=config.joinpath("hypr"),
        ),
        # "neovim",
        # "waybar",
        # "wezterm",
    ]

    match kanshi_profile:
        case "laptop":
            ...
        case "docked":
            ...
        case _:
            print(f"unexpected kanshi profile: {kanshi_profile}")


if __name__ == "__main__":
    main(sys.argv[1])
