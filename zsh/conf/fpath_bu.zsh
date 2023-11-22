# This whole bit is weird.
# Basically, this allows me to place my dotfiles dir anywhere, and to easily 
# autoload all my zsh functions, both when running `exec $SHELL` and 
# `source ~/.zshrc`.

# This runs when starting a new shell
if [[ "$0" == "-zsh" ]]; then
    # Basically, this just ignores that $0 == "-zsh", and instead execs 
    # $SHELL, which changes $0 to $(which zsh), which then sources this file 
    # (see the `elif` about 55 lines below).
    exec $SHELL
# This runs when calling directly either via `exec $SOURCE` or `source .zshrc`
else
    if [[ $(uname) == "Darwin" ]]; then
        # if greadlink is found
        # Gets the absolute dir path of the file being run.
        # If running `exec $SHELL`, $this_file_name == $(basename $(which zsh));
        # if running `source ~/.zshrc`, $this_file_name == ".zshrc" (if reading 
        # symlink) or "zshrc" (if reading absolute path in dotfiles repo).
        #
        # Uses greadlink in place of readlink so that I can get Linux-like `-f` functionality.
        # If greadlink not installed, run `brew install coreutils`.
        this_file=$(greadlink -f "$0")
        this_file_name=$(basename "$this_file")
        this_dir=$(greadlink -f $(dirname "$this_file"))
        this_dir_name=$(basename "$this_dir")

    elif [[ $(uname) == "Linux" ]]; then
        this_file=$(readlink -f $0)
        this_file_name=$(basename "$this_file")
        this_dir=$(readlink -f $(dirname "$this_file"))
        this_dir_name=$(basename "$this_dir")
    
    else
        echo "Haven't yet dealt with $(uname)."
        echo "TODO: write logic for this!"
    fi
    
    echo "This file: $this_file"
    echo "This file name: $this_file_name"
    echo "This file's parent dir: $this_dir"
    echo "This file's parent dir name: $this_dir_name"
    
    # reading `~/.zshrc` symlink
    # This shouldn't run, since `(g)readlink -f` is resolving to the absolute path.
    # if [[ "$this_file_name" == ".zshrc" ]] && [[ "$this_dir" == "$HOME" ]]; then
    if [[ "$this_file_name" == ".zshrc" ]]; then
        echo "\`source\`-ing..."
    
        # TODO: need to `find` dotfiles dir and then read from there
        echo "Running from $this_dir"
    
    # reading `.../dotfiles/zshrc` absolute path
    # elif [[ "$this_file_name" == "zshrc" ]] && [[ "$this_dir_name" == "dotfiles" ]]; then 
    elif [[ "$this_file_name" == "zshrc" ]]; then 
        # echo "\`source\`-ing..."
    
        # Sets the directory for user functions
        user_zsh_functions="$this_dir/functions"
        # echo "Adding user zsh functions dir $user_zsh_functions to FPATH..."
        FPATH="${user_zsh_functions}:$FPATH"
    
        # Autoloads all functions in the user functions directory.
        # Don't forget that the functions need the .zsh extension removed 
        # before they're able to be used!
        # echo "Autoloading zsh functions..."
        for func in "$user_zsh_functions"/*; do
            # echo "\t$(basename "$func")"
            autoload -Uz "$func"
        done
        # echo "ZSH user functions loaded!"
    
    # elif [[ "$this_file" == "$(which zsh)" ]] && [[ "$this_file_name" == "zsh" ]]; then
    elif [[ "$this_file_name" == "zsh" ]]; then
        # echo "\`exec\`-ing $this_file..."
        # echo "\`source\`-ing..."
        source "$HOME/.zshrc"
    else
        echo "Taking the else...something went wrong."
    fi
fi
