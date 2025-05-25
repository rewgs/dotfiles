from socket import gethostname

from .base import CONFIG, DOTFILES, App


class Fuzzel(App):
    def __init__(self):
        super().__init__(
            name="fuzzel",
            src=DOTFILES.joinpath("fuzzel", "dots"),
            dst=CONFIG.joinpath("fuzzel", "fuzzel.ini"),
        )


class Hyprland(App):
    def __init__(self):
        super().__init__(
            name="hyprland",
            src=DOTFILES.joinpath("hypr", "dots"),
            dst=DOTFILES.joinpath("hypr", "dots", gethostname()),
        )


class Waybar(App):
    def __init__(self):
        super().__init__(
            name="waybar",
            src=DOTFILES.joinpath("waybar", "dots", "hyprland"),
            dst=CONFIG.joinpath("waybar"),
        )


class Wezterm(App):
    def __init__(self):
        super().__init__(
            name="wezterm",
            src=DOTFILES.joinpath("wezterm", "dots"),
            dst=DOTFILES.joinpath("wezterm", "dots", gethostname()),
        )
