#!/usr/bin/env python3


from dataclasses import dataclass


@dataclass
class GroupOptions:
    is_group_member: bool
    is_group_host: bool


@dataclass
class App:
    name: str
    workspace: int
    group_options: GroupOptions


desktop_1 = [
    "zen-browser",
    "discord",
    "element-desktop",
    "signal-desktop",
    "bitwarden-desktop",
    "spotify",
]

desktop_2 = ["google-chrome-stable --profile-directory='Profile 1' --new-window"]

desktop_3 = ["google-chrome-stable --profile-directory='Profile 2' --new-window"]

desktop_10 = ["obsidian"]


def main(): ...
