import os
from abc import ABC, abstractmethod
from pathlib import Path


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


class App(ABC):
    """An application configured via dotfiles."""

    def __init__(self, name: str, src: Path, dst: Path):
        self.name: str = name
        self.src: Path = src
        self.dst: Path = dst

    @abstractmethod
    def change_config(self, kanshi_profile: str):
        """Changes to another config based on the provided Kanshi profile."""
