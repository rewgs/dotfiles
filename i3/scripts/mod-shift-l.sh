#!/bin/bash

# TODO: make this work! Currently not changing behavior any differently than stock.

window_start=$(xwininfo -id $(xdotool getactivewindow) | grep 'Absolute upper-left X' | cut -f2 -d':')
window_width=$(xwininfo -id $(xdotool getactivewindow) | grep 'Width' | cut -f2 -d':') 
window_end=$((window_start + window_width))
screen_end=$(($(xdpyinfo | awk '/dimensions/{print $2}' | cut -f1 -d'x') - 10))

# echo $window_start
# echo $window_width
# echo $window_end
# echo $screen_end

if [[ $window_end > $screen_end ]]; then 
    # echo "if"
    i3-msg resize shrink width 10 px or 10 ppt 
elif [[ $window_start < 10 ]]; then # not sure if this elif is needed
    # echo "elif"
    i3-msg resize grow width 10 px or 10 ppt 
else
    # echo "else"
    i3-msg resize grow width 10 px or 10 ppt 
fi
