from pathlib import Path


class Kanshi:
    def __init__(self, config_file: Path | None = None):
        self.config_file: Path = (
            Path.home().joinpath(".config", "kanshi", "config")
            if config_file is None
            else config_file
        )

    # TODO: test!
    def get_profiles(self) -> tuple[str, ...]:
        """Reads the kanshi config file and returns all profile names."""
        profiles: list[str] = []
        with open(self.config_file, "r") as file:
            for line in file:
                if line.startswith("profile") and line.endswith("{"):
                    _1: str = line.replace("profile", "")
                    _2: str = _1.replace("{", "")
                    profile: str = _2.strip()
                    profiles.append(profile)
        return tuple(profiles)
