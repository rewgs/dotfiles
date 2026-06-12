#!/usr/bin/env python3
#
# Renames the active workspace.

import subprocess
import sys


class Workspace:
    def __init__(self):
        self._workspace: list[str] = _get_active_workspace().split()
        self._id: str = self._workspace[2]
        self._name: str = self._workspace[3]

    def rename(self, new_name: str) -> None:
        try:
            result: str = (
                subprocess.check_output(
                    ["hyprctl", "dispatch", "renameworkspace", self._id, new_name]
                )
                .decode("utf-8")
                .strip()
            )
        except subprocess.CalledProcessError as e:
            print(
                f"Error renaming workspace {self._id} name from {self._name} to {new_name}"
            )
            raise e


def _get_active_workspace() -> str:
    try:
        result: str = (
            subprocess.check_output(["hyprctl", "activeworkspace"])
            .decode("utf-8")
            .strip()
        )
    except subprocess.CalledProcessError as e:
        print("Error while getting active workspace")
        raise e
    else:
        return result


def main():
    if len(sys.argv) <= 1:
        print("New workspace name not provided. Exiting.")
        exit()

    workspace = Workspace()
    workspace.rename(sys.argv[1])


if __name__ == "__main__":
    main()
