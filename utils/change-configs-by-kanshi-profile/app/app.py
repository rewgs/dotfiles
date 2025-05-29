from dataclasses import dataclass
from pathlib import Path
from socket import gethostname


@dataclass
class App:
    """An application configured via dotfiles."""

    name: str
    src: Path
    dst: Path

    def change_config(self, kanshi_profile: str):
        target_is_directory: bool = True
        config_name: str = f"{gethostname()} {kanshi_profile}"
        if self.dst.resolve().name != config_name:
            config: Path = self.src.joinpath(config_name)
            if config.is_file():
                target_is_directory = False
            try:
                resolved: Path = config.resolve(strict=True)
            except FileNotFoundError as error:
                print(
                    f"Config for {self.name} with Kanshi profile {kanshi_profile} does not exist!\n"
                )
                raise error
            else:
                self.dst.unlink()
                self.dst.symlink_to(resolved, target_is_directory=target_is_directory)
