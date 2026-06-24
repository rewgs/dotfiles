if [ "$(uname)" = "Darwin" ]; then
    _hs_path="/Applications/Hammerspoon.app/Contents/Frameworks/hs/hs"
    if [ -f "$_hs_path" ]; then
        alias hs="$_hs_path"
    fi
    unset _hs_path
fi
