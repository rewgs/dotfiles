#!/usr/bin/env python3
#
# Chooses a random wallpaper from the `walls-main` repo.
#
# TODO:
# - Do not allow a given wallpaper to be chosen twice before all others have been chosen.

import random
from dataclasses import dataclass, field
from pathlib import Path
from typing import NamedTuple

EXTENSIONS: list[str] = [
    ".jpg",
    ".png",
    ".webp",
]


class Wallpaper(NamedTuple):
    path: Path | None
    err: Exception | None


@dataclass
class Collection:
    """Collection defines a directory of wallpapers."""

    name: str
    dir: Path
    alt_dirs: list[Path] = field(default_factory=list)
    excluded_dirs: list[str] = field(default_factory=list)
    excluded_files: list[str] = field(default_factory=list)

    # TODO: Don't search the root directory, and *then* exclude files if their parent is in EXCLUDED_DIRS -- just search the non-excluded dirs from the get-go!
    def choose_random_wallpaper(self) -> Wallpaper:
        try:
            dir: Path = self.dir.resolve(strict=True)
        except FileNotFoundError:
            try:
                alt_dir: Path = self.alt_dir.resolve(strict=True)
            except FileNotFoundError as e:
                print(f"Directories not found for Collection {self.name}")
                return Wallpaper(None, e)
            else:
                ...
        except Exception as e:
            return Wallpaper(None, e)

        filenames = self.dir.rglob("*")
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


collections: dict[str, Collection] = {
    "local": Collection(name="local", dir=Path(Path.home()).joinpath("wallpapers")),
    "walls": Collection(
        name="walls repo",
        dir=Path(Path.home()).joinpath("Pictures", "walls"),
        alt_dir=Path(Path.home()).joinpath("Pictures", "walls-main"),
    ),
}

collections["walls"].excluded_dirs = [
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

collections["walls"].excluded_files = [
    "a_black_and_green_creature_with_yellow_and_green_objects.png",
    "a_black_and_orange_drawing_of_a_bug.png",
    "a_black_and_white_drawing_of_a_demon_hugging_a_woman.jpg",
    "a_black_and_white_drawing_of_a_horse.png",
    "a_black_and_white_picture_of_a_man_holding_a_devil.jpg",
    "a_black_and_white_picture_of_a_man_in_a_hat.png",
    "a_blue_and_grey_background.png",
    "a_blue_and_white_watercolor.jpg",
    "a_blue_dragon_with_a_banner.jpg",
    "a_blue_drawing_of_a_heart.jpg",
    "a_bowl_of_colorful_macaroons.jpg",
    "a_car_parked_in_a_field_with_trees_and_a_crescent_moon_in_the_sky.png",
    "a_cartoon_of_a_cat.png",
    "a_cartoon_of_a_man_in_a_cape_standing_on_a_rock_with_a_fire_in_the_background.jpg",
    "a_cartoon_of_a_robot.jpg",
    "a_cartoon_of_a_woman_with_her_arms_out.png",
    "a_cartoon_of_mountains_and_snow.png",
    "a_cartoon_of_trees_on_a_hill_01.png",
    "a_cat_looking_at_the_camera.png",
    "a_close_up_of_a_wallpaper.png",
    "a_colorful_logo_with_text.png",
    "a_colorful_logo_with_white_text.png",
    "a_colorful_planets_in_a_circle.jpg",
    "a_colorful_rectangular_sign_with_white_text.png",
    "a_colorful_square_with_black_text_02.png",
    "a_computer_screen_with_a_logo.png",
    "a_cup_with_a_straw.png",
    "a_drawing_of_a_bird_in_a_circle.png",
    "a_drawing_of_a_city.jpg",
    "a_drawing_of_a_man_falling_down.jpg",
    "a_drawing_of_a_man_with_wings_and_a_circular_pattern.jpg",
    "a_drawing_of_a_spider_on_a_white_surface.png",
    "a_floral_pattern_of_flowers.png",
    "a_green_and_blue_rectangular_sign_with_a_drawing_of_a_tree.png",
    "a_group_of_bats_flying_in_the_sky.jpg",
    "a_group_of_people_walking_on_a_hill.png",
    "a_group_of_trees_on_a_small_island_in_front_of_a_colorful_sky.png",
    "a_group_of_vases_with_faces_and_arrows.jpg",
    "a_group_of_white_spheres_with_rings.png",
    "a_hand_holding_a_cable.jpg",
    "a_hand_holding_a_cassette_tape.jpg",
    "a_kitten_sleeping_on_the_ground.jpg",
    "a_large_stone_statues_in_water.png",
    "a_lighthouse_in_front_of_a_building.jpg",
    "a_logo_on_a_red_background_01.png",
    "a_logo_with_circles_and_text.png",
    "a_logo_with_eyes_and_arrow.jpg",
    "a_man_and_woman_in_a_forest.jpg",
    "a_man_riding_a_shark.jpg",
    "a_moon_and_clouds_in_the_sky.jpg",
    "a_multicolored_speckled_surface.png",
    "an_anubis_in_a_circle.jpg",
    "a_painting_of_a_building_in_a_dark_landscape.png",
    "a_painting_of_a_city.png",
    "a_painting_of_flowers_on_a_surface.jpg",
    "a_painting_of_people_in_traditional_clothing.jpg",
    "a_pair_of_playing_cards_on_a_black_surface.jpg",
    "a_pattern_of_flowers_and_leaves_01.jpg",
    "a_pattern_of_flowers_and_leaves.jpg",
    "a_person_playing_a_guitar.png",
    "a_pile_of_wood_with_snow_on_top.jpg",
    "a_pink_circle_with_different_shapes.jpg",
    "a_room_with_a_large_window_and_plants.jpg",
    "a_small_town_with_many_houses.png",
    "a_space_scene_with_planets_and_a_rocket.jpg",
    "a_sports_car_with_neon_lights.png",
    "a_street_with_a_building_and_a_moon_in_the_sky.png",
    "a_town_with_snow_covered_roofs_and_lights.png",
    "a_video_game_screen_shot.png",
    "a_white_line_drawing_of_trees_and_mountains.jpg",
    "a_woman_in_a_pink_dress_with_flowers_on_her_head.png",
    "a_woman_in_a_suit_and_tie.png",
    "a_woman_sitting_on_a_circle.jpg",
    "a_yellow_and_blue_sphere.png",
    "cartoon_of_girls_and_cats.jpg",
    "rpkljnon38aa1.webp",
    "s61f586j38aa1.webp",
    "t5v1ltio38aa1.webp",
    "vouvrx5p38aa1.webp",
]


def main():
    collection: Collection = random.choice(list(collections.values()))

    wallpaper, err = collection.choose_random_wallpaper()
    if err is not None:
        raise err
    if wallpaper is None:
        print("Could not pick wallpaper due to unknown reason. Exiting now.")
        exit()
    else:
        w: str = wallpaper.as_posix()
        with open(Path(Path.home()).joinpath(".wallpaper"), "w") as f:
            _ = f.write(w)
        print(w)


if __name__ == "__main__":
    main()
