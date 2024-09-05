# Sets the directory for user functions
user_zsh_functions="$ZSH_CONFIG/functions"

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
