install-oh-my-zsh::main() {
    # interactive
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # unattended
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # FIXME: the following doesn't work!
    # `< /dev/tty` forces that new shell to start reading input from the terminal. 
    #   Without this, the script would exit, returning to your calling script. I 
    #   don't want this to happen - I want more functions to run aftr this.
    # exec zsh < /dev/tty
}
install-oh-my-zsh::main
