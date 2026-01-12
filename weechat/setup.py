#!/usr/bin/env python3
#
# Clones and installs any plugins, and symlinks dots dir to ~/.config/weechat.

from pathlib import Path
# from urllib.parse import urlparse

class Plugin:
    """Plugin defines a Weechat plugin."""
    def __init__(self, repo: str):
        self.repo: str = repo
        self.script_name: str = "vimode.py" # The plugin that will be symlinked.

    # TODO:
    def clone(self):
        ...

    # TODO:
    def symlink(self):
        ...


class Weechat:
    """Weechat defines the application Weechat."""
    def __init__(self):
        self.config_dir: Path = Path(Path.home()).joinpath(".weechat")
        self.dotfiles_src: Path = Path(__file__).parent.joinpath("dots")
        self.dotfiles_dst: Path = Path(Path.home()).joinpath(".config", "weechat")

    @property
    def autoload_dir(self) -> Path:
        p: Path = self.config_dir.joinpath("autoload")
        if not p.exists():
            try:
                p.mkdir()
            except Exception as e:
                print(f"Unexpected error while making directory: {p}")
                raise e
        return p

    @property
    def scripts_dir(self) -> Path:
        p: Path = self.config_dir.joinpath("python")
        if not p.exists():
            try:
                p.mkdir()
            except Exception as e:
                print(f"Unexpected error while making directory: {p}")
                raise e
        return p

    def symlink_dotfiles(self) -> None:
        if self.dotfiles_dst.exists():
            # NOTE: The directory must be empty!
            self.dotfiles_dst.rmdir() 
        if not self.dotfiles_dst.is_symlink():
            self.dotfiles_dst.symlink_to(self.dotfiles_src)

LOCAL_REPOS: Path = Path(Path.home()).joinpath("src")

plugin_repos: tuple[str, ...] = (
    "https://github.com/GermainZ/weechat-vimode",
)

def main():
    # Doesn't matter until plugin-related stuff is finished, so commenting out for now.
    # if not LOCAL_REPOS.exists():
    #     LOCAL_REPOS.mkdir(parents=True)

    weechat = Weechat()

    # Note finished yet.
    # for repo in plugin_repos:
    #     plugin = Plugin(repo)
    #     plugin.clone()
    #     plugin.symlink()

    weechat.symlink_dotfiles()


if __name__ == "__main__":
    main()
