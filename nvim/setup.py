#!/bin/env python3
#
# Sets up neovim on Unix systems.
# Symlinks the `$DOTFILES/nvim/dots/${package_manager}` dir to `~/.config/nvim`.
#
# TODO: Windows support


from pathlib import Path
from socket import gethostname
import sys


def main():
    PKG_MGR = sys.argv[1] # the first arg that isn't the script's name
    DOTS = Path(__file__).parent.joinpath("dots").resolve(strict=True)
    SRC = DOTS.joinpath(PKG_MGR, gethostname()).resolve(strict=True)
    DST = Path.home().joinpath(".config", "nvim")

    if not DST.parent.exists():
        Path.mkdir(DST.parent)

    if not DST.exists():
        DST.symlink_to(SRC)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        # TODO: Handle this more elegantly.
        print("At least one argument is required! Specify which package manager to use (e.g. packer, lazy).")
        exit()
    main()
