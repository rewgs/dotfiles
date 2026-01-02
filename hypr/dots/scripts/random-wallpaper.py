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
    "halloween",
    "m-26.jp",
    "manga",
]

EXCLUDED_FILES: list[str] = [
    "a_black_and_white_picture_of_a_man_holding_a_devil.jpg",
    "a_blue_and_grey_background.png",
    "a_blue_and_white_watercolor.jpg",
    "a_cartoon_of_a_cat.png",
    "a_cartoon_of_a_man_in_a_cape_standing_on_a_rock_with_a_fire_in_the_background.jpg",
    "a_colorful_rectangular_sign_with_white_text.png",
    "a_cup_with_a_straw.png",
    "a_drawing_of_a_bird_in_a_circle.png",
    "a_drawing_of_a_man_falling_down.jpg",
    "a_floral_pattern_of_flowers.png",
    "a_hand_holding_a_cable.jpg",
    "a_large_stone_statues_in_water.png",
    "a_man_and_woman_in_a_forest.jpg",
    "a_man_riding_a_shark.jpg",
    "a_painting_of_a_building_in_a_dark_landscape.png",
    "a_pink_circle_with_different_shapes.jpg",
    "a_room_with_a_large_window_and_plants.jpg",
    "a_small_town_with_many_houses.png",
    "a_video_game_screen_shot.png",
    "a_woman_in_a_pink_dress_with_flowers_on_her_head.png",
    "a_colorful_square_with_black_text_02.png",
    "a_pattern_of_flowers_and_leaves.jpg",
    "a_pattern_of_flowers_and_leaves_01.jpg",
]


# TODO: Don't search the root directory, and *then* exclude files if their parent
# is in EXCLUDED_DIRS -- just search the non-excluded dirs from the get-go!
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
        Path(file) for file in filenames if file.name not in EXCLUDED_FILES
    ]
    not_excluded_dirs: list[Path] = [
        file for file in not_excluded_files if file.parent.name not in EXCLUDED_DIRS
    ]
    valid_extensions: list[Path] = [
        file for file in not_excluded_dirs if file.suffix in EXTENSIONS
    ]
    wallpaper = random.choice(valid_extensions)
    return wallpaper


def main():
    wallpaper = choose_random_wallpaper(WALLPAPERS_DIR)

    w = wallpaper.as_posix()
    with open(Path(Path.home()).joinpath(".wallpaper"), "w") as f:
        _ = f.write(w)

    print(w)


if __name__ == "__main__":
    main()

