from .apps import Fuzzel, Hyprland, Waybar, Wezterm
from .base import App

fuzzel = Fuzzel()
hyprland = Hyprland()
waybar = Waybar()
wezterm = Wezterm()

to_config: list[App] = [fuzzel, hyprland, waybar, wezterm]

# __all__ = ["Fuzzel", "Hyprland", "Waybar", "Wezterm"]
# __all__ = ["fuzzel", "hyprland", "waybar", "wezterm"]
__all__ = ["to_config"]
