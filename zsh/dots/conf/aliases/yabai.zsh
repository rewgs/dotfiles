if [[ $(uname) == "Darwin" ]]; then
    alias yst="brew services start yabai && brew services start skhd"
    alias ysp="brew services stop yabai && brew services stop skhd"
    alias yr="brew services restart yabai && brew services restart skhd"
fi
