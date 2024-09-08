# Sets up neovim.
# Symlinks the `$DOTFILES/nvim/dots/${package_manager}/${hostname}` dir to `~/.config/nvim`.
#
# TODO: Windows support


from pathlib import Path
from socket import gethostname
from typing import Optional
import sys


def main():
    PACKAGE_MANAGER = "lazy"

    dots = Path(__file__).parent.joinpath("dots")
    try:
        dots_r = dots.resolve(strict=True)
    except FileNotFoundError as error:
        raise error

    src = dots_r.joinpath(PACKAGE_MANAGER, gethostname())
    try:
        src_r = src.resolve(strict=True)
    except FileNotFoundError as error:
        raise error

    dst = Path.home().joinpath(".config", "nvim")
    if not dst.parent.exists(): 
        Path.mkdir(dst.parent)
    if not dst.exists():
        dst.symlink_to(src)
        print(f"Symlinked {src} to {dst}!")


if __name__ == "__main__":
    main()
