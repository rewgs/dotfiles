from os import environ as env
from time import sleep

from dfmgr.manager import Manager


def main():
    if not 'DOTFILES' in env:
        print('DOTFILES not in env. Check your .zshrc and try again.')
        print('Exiting...')
        sleep(3)
        exit()

    mgr = Manager()
    mgr.print_dot_apps()

if __name__ == "__main__":
    main()
