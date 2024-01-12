# from dataclasses import dataclass
# from pathlib import Path
# from pathlib import PurePath
# import subprocess
# from os import environ as env

# from dots import DotApp
from dfmgr.dots import DotApp
from dotfiles.bash_shell import bashrc, bash_profile


class Manager:
    """
    Responsible for locating and running various functions on all DotApps.
    """

    # TODO: make this dynamically add all files from dotfiles dir
    def __get_dot_apps(self) -> set:
        bash_shell_da = DotApp("bash", (bashrc, bash_profile))

        dot_apps: set = {
            bash_shell_da
        }
        return dot_apps

    def __init__(self):
        self.dot_apps = self.__get_dot_apps()

    def print_dot_apps(self):
        for d in self.dot_apps:
            print(f"{d.name} has the following dotfiles:")
            for file in d.dotfiles:
                print(f"{file.name}:")
                print(f"\tlocated at {file.src};")
                print(f"\tsymlinked to {file.dst}")
