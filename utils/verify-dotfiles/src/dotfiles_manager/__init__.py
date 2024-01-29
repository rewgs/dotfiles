from os import environ as env
from time import sleep

from .dotfiles_manager import Dotfile, Definition, Dotfiles


__all__ = ["Dotfiles"]


if not 'DOTFILES' in env:
    print('DOTFILES not in env. Check your .zshrc and try again.')
    print('Exiting...')
    sleep(3)
    exit()
