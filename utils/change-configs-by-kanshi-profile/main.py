#!/usr/bin/env python3
#
# Runs via `exec` command in kanshi config: https://man.archlinux.org/man/kanshi.5.en
#
# This is primarily for improving font sizes for a given kanshi profile;
# e.g. font should be smaller when on laptop display, but larger when on Apple Pro Display XDR

# class KanshiProfile:

import sys

from apps import to_config


def main(kanshi_profile: str):
    for app in to_config:
        app.change_config(kanshi_profile)


if __name__ == "__main__":
    try:
        main(sys.argv[1])
    except IndexError as error:
        print("One Kanshi profile name is required!\n")
        raise error
