# TODO:
# - Be able to "copy" an already-existing Preset and add/subtract dots from it.
#   For example, the "basic cli" preset with additional dots hyprland, waybar,
#   wezterm, and pacman would basically be my Arch setup.
#   It'd be great to be able to do something like:
#   `duplicate_preset("basic cli").add_dots("hyprland", "waybar", "wezterm", "pacman")`
# - Be sure this is running with a minimum version of Python. Dataclasses were introduced in 3.7 -- should probably be that.

# Runs one or more dotfiles' `setup.sh` scripts.
# Options:
# -A, --all: Finds and runs every single `setup.sh` script in this repo.
# -p, --preset PRESET: Select a preset list of applications by name; a preset contains a subset of applications.


import subprocess
from dataclasses import dataclass
from pathlib import Path
from platform import system


@dataclass
class Preset:
    """A collection of dotfile-configured applications to setup, optionally contrained by operating system."""
    name: str
    dots: tuple[str, ...]
    # A value of None means that this Preset can be setup on any OS.
    os: str | tuple[str, ...]


presets: tuple[Preset, ...] = (
    Preset(
        name="basic cli",
        dots=(
            "bash",
            "btop",
            "git",
            "nvim",
            "sh",
            "starship",
            "tmux",
            "vim",
            "zsh",
        ),
        os=(
            "Darwin",
            "Linux",
        ),
    ),
    Preset(
        name="cross-platform cli",
        dots=(
            "git",
            "nushell",
            "nvim",
            "powershell",
            "starship",
        ),
        os=(
            "Darwin",
            "Linux",
            "Windows",
        ),
    ),
    Preset(
        name="arch gui",
        dots=(
            "bash",
            "btop",
            "git",
            "hypr",
            "nvim",
            "pacman",
            "sh",
            "starship",
            "tmux",
            "vim",
            "waybar",
            "wezterm",
            "zsh",
        ),
        os=("Linux"),
    ),
)


def setup(dotfiles_dir: Path, preset: Preset) -> tuple[set[str], set[str]]:
    """Runs the setup script for each dot in the specified Preset."""

    succeeded: set[str] = set()
    failed: set[str] = set()

    if system() not in preset.os:
        raise Exception("Invalid operating system!")

    for dot in preset.dots:
        path: Path = dotfiles_dir.joinpath(dot, "setup.sh")
        try:
            resolved: Path = path.resolve(strict=True)
        except FileNotFoundError:
            failed.add(dot)
        else:
            try:
                _: subprocess.CompletedProcess[bytes] = subprocess.run([resolved])
            except subprocess.CalledProcessError:
                failed.add(dot)
            else:
                succeeded.add(dot)

    return succeeded, failed


def get_preset(name: str) -> Preset:
    """Searches for a Preset with the given name. Returns None if it can't be found."""
    preset: list[Preset] = [preset for preset in presets if preset.name == name]
    if len(preset) == 0:
        raise Exception(f"Could not find preset with name {name}!")
    # TODO:
    if len(preset) > 1:
        raise NotImplementedError
    return preset[0]


def main():
    dotfiles_dir: Path = Path(__file__).resolve().parent
    if dotfiles_dir.name != "dotfiles":
        raise Exception("This file must be in the root of the dotfiles repo!")

    # testing; TODO: Specify name with cli arg.
    name = "basic cli"
    succeeded, failed = setup(dotfiles_dir, get_preset(name))
    if len(succeeded) == 0 or len(failed) > 0:
        raise Exception(
            f"The following dots failed to setup: {[dot for dot in failed]}"
        )


if __name__ == "__main__":
    main()
