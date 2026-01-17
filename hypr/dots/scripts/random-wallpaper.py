#!/usr/bin/env python3
#
# Chooses a random wallpaper from the `walls-main` repo.

import random
from pathlib import Path

# TODO: Add other directories to choose from.
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
	"a_yellow_and_blue_sphere.png",
	"a_close_up_of_a_wallpaper.png",
	"a_woman_sitting_on_a_circle.jpg",
	"a_cartoon_of_a_woman_with_her_arms_out.png",
	"s61f586j38aa1.webp",
	"a_sports_car_with_neon_lights.png",
	"a_group_of_vases_with_faces_and_arrows.jpg",
	"a_space_scene_with_planets_and_a_rocket.jpg",
	"a_pile_of_wood_with_snow_on_top.jpg",
	"a_black_and_orange_drawing_of_a_bug.png",
	"a_cartoon_of_mountains_and_snow.png",
	"a_green_and_blue_rectangular_sign_with_a_drawing_of_a_tree.png",
	"a_cartoon_of_trees_on_a_hill_01.png",
	"rpkljnon38aa1.webp",
	"a_black_and_white_drawing_of_a_horse.png",
	"a_colorful_planets_in_a_circle.jpg",
	"a_lighthouse_in_front_of_a_building.jpg",
	"a_woman_in_a_suit_and_tie.png",
    "a_computer_screen_with_a_logo.png",
    "a_colorful_logo_with_text.png",
    "a_pair_of_playing_cards_on_a_black_surface.jpg",
    "a_bowl_of_colorful_macaroons.jpg",
    "cartoon_of_girls_and_cats.jpg",
    "a_painting_of_a_city.png",
    "a_blue_dragon_with_a_banner.jpg",
    "a_black_and_white_drawing_of_a_demon_hugging_a_woman.jpg",
    "a_drawing_of_a_man_with_wings_and_a_circular_pattern.jpg",
    "a_street_with_a_building_and_a_moon_in_the_sky.png",
    "a_group_of_white_spheres_with_rings.png",
    "a_town_with_snow_covered_roofs_and_lights.png",
    "an_anubis_in_a_circle.jpg",
    "a_black_and_white_picture_of_a_man_in_a_hat.png",
    "a_cat_looking_at_the_camera.png",
    "vouvrx5p38aa1.webp",
    "a_person_playing_a_guitar.png",
    "a_car_parked_in_a_field_with_trees_and_a_crescent_moon_in_the_sky.png",
    "t5v1ltio38aa1.webp",
    "a_logo_with_eyes_and_arrow.jpg",
    "a_group_of_people_walking_on_a_hill.png",
    "a_logo_with_circles_and_text.png",
    "a_blue_drawing_of_a_heart.jpg",
    "a_white_line_drawing_of_trees_and_mountains.jpg",
    "a_painting_of_people_in_traditional_clothing.jpg",
    "a_group_of_trees_on_a_small_island_in_front_of_a_colorful_sky.png",
    "a_painting_of_flowers_on_a_surface.jpg",
    "a_kitten_sleeping_on_the_ground.jpg",
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
