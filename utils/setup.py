#!/usr/bin/env python3
#
# Loops through all apps in `dotfiles`, checks if a given app is installed;
# if so, checks for a `setup` script; if found, runs it.


from pathlib import Path


def main():
    utils = Path(__file__).parent.resolve(strict=True)
    dotfiles = utils.parent.resolve(strict=True)

    for d in dotfiles.iterdir():
        if d != utils and d.is_dir():
            app_name = d.name
            print(app_name)

        # TODO: Check if app is installed



if __name__ == "__main__":
    main()
