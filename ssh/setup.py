#!/usr/bin/env python3
#
# Sets up the machine's ssh config.
#
# If `~/.ssh/config` file does NOT exist, `rewgs_ssh_config` in this repo is symlinked to `~/.ssh/config`.
#
# If `~/.ssh/config` DOES exist:
#   1. SSH version is checked.
#       - If version is below 7.3, this script exits with an error -- version 7.3 or above is required to use the `Include` directive.
#       - If version is 7.3 or above, this script continues.
#   2. `rewgs_ssh_config` in this repo is symlinked to `~/.ssh/rewgs_ssh_config`.
#   3. The following line is prepended to the pre-existing `~/.ssh/config` file: `Include ~/.ssh/rewgs_ssh_config`

import platform
import subprocess
from pathlib import Path


class SSH:
    def __init__(self):
        self.cutoff: str = "7.3"
        self.path: Path = self._get_path()

    @staticmethod
    def _get_path() -> Path:
        cmd: str = "where" if platform.system() == "Windows" else "which"
        result: str = subprocess.check_output([cmd, "ssh"]).decode("utf-8").strip()
        try:
            path: Path = Path(result).resolve()
        except FileNotFoundError as error:
            raise error
        return path

    @staticmethod
    def get_major_version(s: str) -> int:
        major_version_string: str = s.split(".")[0] if "." in s else s
        major_version: int = int(major_version_string)
        return major_version

    @staticmethod
    def get_minor_version(s: str) -> int:
        minor_version_string: str = s.split(".")[1] if "." in s else s
        minor_version: int = int(minor_version_string)
        return minor_version

    @property
    def version(self):
        def get_version() -> str:
            try:
                # NOTE: Apparently this command returns via stderr? Bizarre.
                result: str = subprocess.check_output(
                    [self.path.as_posix(), "-V"], stderr=subprocess.STDOUT
                ).decode("utf-8")
            except subprocess.CalledProcessError as error:
                raise error

            if result == "":
                raise Exception("Could not get SSH version!")

            return result

        def parse_version() -> str:
            version: str = get_version()
            if "," not in version:
                return version

            split: list[str] = version.split(",")
            if "OpenSSH" not in split[0]:
                raise Exception(f"Could not parse SSH version: {version}")

            version_split: list[str] = split[0].split("_")
            if version_split[0] != "OpenSSH":
                raise Exception(f"Could not parse SSH version: {version}")

            return version_split[1]

        return parse_version()

    def version_is_valid(self) -> bool:
        current: str = self.version

        if self.get_major_version(current) > self.get_major_version(self.cutoff):
            return True
        if self.get_major_version(current) == self.get_major_version(self.cutoff):
            if self.get_minor_version(current) >= self.get_minor_version(self.cutoff):
                return True
        return False


def exists(path: Path) -> bool:
    """
    Checks if the given path exists. This function should be used in place of path.exists(), as
    this function deals with pathlib API changes that occurred in Python version 3.12.

    Ideally, this is running with Python 3.12 or greater, which allows us to use the
    path.exists(follow_symlinks=False) param. This is helpful because, if the link exists,
    its path will not be followed to the file it's pointing to. Without this parameter,
    path.exists() where path is a symlink will resolve the path and check if *that* file exists.

    However, many environments will only support up to Python 3.11. In this version, if path.exists()
    where path is a symlink If the path points to a symlink returns whether the symlink points to
    an existing file or directory.

    As the follow_symlinks parameter is not available in <= Python 3.11, running path.exists()
    with a follow_symlinks parameter will result in a TypeError.

    In this function, if a TypeError is raised, path.is_symlink() is called instead. If path
    does not exist, it returns False.
    """
    exists: bool
    try:
        exists = path.exists(follow_symlinks=False)
    except TypeError:
        exists = path.is_symlink()  # Returns false if doesn't exist.
    except Exception as error:
        print(f"Unexpected error when checking if exists: {path.as_posix()}")
        raise error
    return exists


def create_symlink(link: Path, target: Path) -> None:
    if not exists(link):
        try:
            link.symlink_to(target)
        except Exception as error:
            raise error
        if link.exists() and link.is_symlink():
            print(f"Created symlink at {link} pointing to {target}.")
            return
        else:
            raise Exception(
                f"Unknown error creating symlink at {link} pointing to {target}."
            )


def main() -> None:
    SRC: Path = Path(__file__).parent.joinpath("rewgs_ssh_config")
    DST: Path = Path.home().joinpath(".ssh", "rewgs_ssh_config")
    SSH_CONFIG: Path = Path.home().joinpath(".ssh", "config")
    DIRECTIVE: str = "Include ~/.ssh/rewgs_ssh_config\n"

    # If ~/.ssh/config does not exist, the SNS file is symlinked to it.
    if not exists(SSH_CONFIG):
        create_symlink(link=SSH_CONFIG, target=SRC)
        return
    else:
        if not exists(DST):
            create_symlink(link=DST, target=SRC)
    try:
        # NOTE: Opening a file with "w" (write) and not "a" (append) mode, writing
        # will trunctuate the file to zero length (i.e. deleting its contents) before writing.
        # Since we need to *prepend* to the file, "w" (write) mode must be used.
        # This is why we're reading and saving the old content to the `existing_content` variable.
        with open(SSH_CONFIG.as_posix(), "r") as file:
            existing_content: str = file.read()

        # Prevents duplicating Include directive.
        if existing_content == DIRECTIVE or DIRECTIVE in existing_content:
            return

        with open(SSH_CONFIG.as_posix(), "w") as file:
            _: int = file.write(DIRECTIVE)
            _: int = file.write(existing_content)
    except Exception as error:
        raise error


if __name__ == "__main__":
    ssh = SSH()
    if not ssh.version_is_valid():
        raise Exception(
            f"SSH version is not high enough to run. Need: {ssh.cutoff}; Have: {ssh.version}"
        )
    main()
