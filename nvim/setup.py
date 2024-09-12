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

    pm = dots_r.joinpath(PACKAGE_MANAGER)
    try:
        pm_r = pm.resolve(strict=True)
    except FileNotFoundError as error:
        raise error

    src = pm_r.joinpath(gethostname())
    try:
        src_r = src.resolve(strict=True)
    except FileNotFoundError as error:
        if not src.exists():
            print(f"{src} does not exist! What would you like to do?")
            res = input("""
                c: Copy a pre-existing config.
                s: Symlink to a pre-existing config.
                e: Exit.
            """)
            configs = [i for i in pm_r.iterdir() if i.is_dir()]
            # TODO: Allow capital letters as well
            match res:
                case "c":
                    print("The following configs are available:")
                    for i, c in enumerate(configs):
                        print(f"{i}. {c.name}")
                    to_copy = input("Which config would you like to copy?")

                    # TODO: Make this recursive
                    if to_copy not in configs:
                        print(f"{to_copy} is not a valid choice!")
                    # TODO:
                    # copy `to_copy`
                case "s":
                    print("The following configs are available:")
                    for i, c in enumerate(configs):
                        print(f"{i}. {c.name}")
                    to_symlink = input("Which config would you like to symlink to?")

                    # TODO: Make this recursive
                    if to_symlink not in configs:
                        print(f"{to_symlink} is not a valid choice!")
                    # TODO:
                    # symlink `to_symlink`
                case "e":
                    print("Goodbye!")
                    exit()
                # TODO: Make this recursive.
                case _:
                    print("Invalid input!")
    else:
        dst = Path.home().joinpath(".config", "nvim")
        if not dst.parent.exists(): 
            Path.mkdir(dst.parent)
        if not dst.exists():
            dst.symlink_to(src_r)
            print(f"Symlinked {src_r} to {dst}!")


if __name__ == "__main__":
    main()
