#!/usr/bin/env python3
#
# Sets up all applications via their respective `setup.sh` or `setup.ps1` scripts.

from dataclasses import dataclass
from pathlib import Path
from platform import system
from subprocess import run, CalledProcessError, CompletedProcess


@dataclass
class Dot:
    name: str
    path: Path
    setup_script: Path

    def setup(self) -> CalledProcessError|CompletedProcess:
        result: CalledProcessError|CompletedProcess = run(self.setup_script, check=True)
        return result


def get_dots(dotfiles_dir: Path) -> list[Dot]:
    def get_setup_script(dir: Path) -> Path|None:
        match system():
            case "Windows":
                matches: list[Path] = [ file for file in dir.iterdir() if file.is_file() and (file.name == "setup.ps1" or file.name == "setup.py") ]
                if len(matches) != 1:
                    return None
                else:
                    return matches[0]
            case _:
                matches: list[Path] = [ file for file in dir.iterdir() if file.is_file() and (file.name == "setup.sh" or file.name == "setup.py") ]
                if len(matches) != 1:
                    return None
                else:
                    return matches[0]

    dots: list[Dot] = []
    dirs: list[Path] = [ dir for dir in dotfiles_dir.iterdir() if dir.is_dir() and any(file for file in dir.iterdir() if file.is_file() and file.stem == "setup") ]
    for d in dirs:
        setup_script = get_setup_script(d)
        if setup_script is not None:
            dot = Dot(name=d.name, 
                      path=d, 
                      setup_script=setup_script)
            dots.append(dot)
    return dots


def main():
    dotfiles_dir = Path(__file__).parent.parent.resolve(strict=True)
    if dotfiles_dir.name != "dotfiles":
        raise FileNotFoundError

    dots: list[Dot] = get_dots(dotfiles_dir)
    failed: list[Dot] = []

    for dot in dots:
        result = dot.setup()
        if isinstance(result, CalledProcessError):
            failed.append(dot)

    if len(failed) > 0:
        print("The following dots failed to setup:")
        for f in failed:
            print(f.name)


if __name__ == "__main__":
    main()
