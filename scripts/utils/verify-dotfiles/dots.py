from dataclasses import dataclass
from pathlib import Path
from pathlib import PurePath
import subprocess
from os import environ as env


@dataclass
class Dot:
    """
    A single dotfile.
    """
    name: str
    src: Path
    dst: Path


class Dots:
    """
    Describes the collection of all dotfiles for a given application, e.g. zsh, 
    neovim, etc, as well as information regarding the application itself.

    Called "Ellipsis" because many dots form an ellipsis.
    """

    def __get_exec_path(self):
        exec_s: str = subprocess.check_output(["which", self.name]).decode('utf-8').strip()
        exec_p: Path = Path(exec_s)
        try:
            exec_p.resolve(strict=True)
        except Exception as error:
            raise error
        else:
            return Path(exec_p).resolve(strict=True)

    def __init__(self, name, dotfiles):
        self.name: str = name
        self.dotfiles: tuple = dotfiles
        self.exec_path: Path = self.__get_exec_path()
        self.home: Path = Path(PurePath.joinpath(Path(env["DOTFILES"]), self.name)).resolve(strict=True)

    def print_dotfiles(self):
        print(f"{self.name} contains the following dotfiles:")
        for d in self.dotfiles:
            print(d.name)

    def verify_dotfiles(self):
        for d in self.dotfiles:
            if not d.src.exists():
                print(f"{d.src.as_posix()} does not exist!")

            if d.dst.exists():
                if not d.dst.is_symlink():
                    # TODO: add prompt for user input
                    print(f"{d.dst.as_posix()} exists, but it's not a symlink! Delete?")
                else:
                    # TODO: add prompt for user input
                    print(f"{d.dst.as_posix()} is a symlink! Recreate?")



