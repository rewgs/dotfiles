from os import environ as env
from time import sleep

from dots import Dots
from dotfiles.bash_shell import bashrc, bash_profile


def main():
    if not 'DOTFILES' in env:
        print('DOTFILES not in env. Check your .zshrc and try again.')
        print('Exiting...')
        sleep(3)
        exit()

    bash_shell = Dots("bash", (bashrc, bash_profile))



if __name__ == "__main__":
    main()
