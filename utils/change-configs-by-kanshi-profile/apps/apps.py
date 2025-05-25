from .base import CONFIG, DOTFILES, App


class Fuzzel(App):
    def __init__(self):
        super().__init__(
            name="fuzzel",
            src=DOTFILES.joinpath("fuzzel", "dots"),
            dst=CONFIG.joinpath("fuzzel"),
        )

    # TODO:
    def change_config(self, kanshi_profile: str): ...


class Hyprland(App):
    def __init__(self):
        super().__init__(
            name="hyprland",
            src=DOTFILES.joinpath("hypr", "dots"),
            dst=CONFIG.joinpath("hypr"),
        )

    # TODO:
    def change_config(self, kanshi_profile: str): ...


class Waybar(App):
    def __init__(self):
        super().__init__(
            name="waybar",
            src=DOTFILES.joinpath("waybar", "dots", "hyprland"),
            dst=CONFIG.joinpath("waybar"),
        )

    # TODO:
    def change_config(self, kanshi_profile: str): ...


class Wezterm(App):
    def __init__(self):
        super().__init__(
            name="wezterm",
            src=DOTFILES.joinpath("wezterm", "dots"),
            dst=CONFIG.joinpath("wezterm"),
        )

    # TODO:
    def change_config(self, kanshi_profile: str): ...
