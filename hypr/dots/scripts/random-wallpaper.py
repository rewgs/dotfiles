#!/usr/bin/env python3
#
# Chooses a random wallpaper from the `walls-main` repo.

import random
from pathlib import Path

WALLPAPERS_DIR: Path = Path(Path.home()).joinpath("Pictures", "walls-main")
EXTENSIONS: list[str] = [
    ".jpg",
    ".png",
    ".webp",
]
EXCLUDED_DIRS: list[str] = [
    "animated",
    "anime",
    "cherry",
    "devicons",
    "evangelion",
    "flowers",
    "girl",
    "m-26.jp",
    "manga",
]
EXCLUDED_FILES: list[str] = []


# TODO: Don't search the root directory, and *then* exclude files if their parent is in EXCLUDED_DIRS -- just search the non-excluded dirs from the get-go!
def choose_random_wallpaper(dir: Path) -> Path:
    try:
        resolved: Path = dir.resolve(strict=True)
    except FileNotFoundError:
        print(f"Wallpapers directory not found: {dir.as_posix()}")
        exit()
    except Exception as error:
        print("Unexpected error")
        raise error

    filenames = resolved.rglob("*")
    not_excluded_files: list[Path] = [
        Path(file) for file in filenames if file not in EXCLUDED_FILES
    ]
    not_excluded_dirs: list[Path] = [
        file for file in not_excluded_files if file.parent not in EXCLUDED_DIRS
    ]
    valid_extensions: list[Path] = [
        file for file in not_excluded_dirs if file.suffix in EXTENSIONS
    ]
    wallpaper = random.choice(valid_extensions)
    return wallpaper


def main():
    wallpaper = choose_random_wallpaper(WALLPAPERS_DIR)
    print(wallpaper.as_posix())


if __name__ == "__main__":
    main()
