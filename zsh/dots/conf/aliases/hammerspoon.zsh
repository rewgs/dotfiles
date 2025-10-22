# This points directly to the `hs` command line tool.
# One can put this function in Hammerspoon's init.lua file, like so: https://www.hammerspoon.org/docs/hs.ipc.html#cliInstall
# ...but it likes to fail (and did not work for me) -- see: https://www.reddit.com/r/hammerspoon/comments/10v59ln/having_issues_with_hsipccliinstall/
# This achieves the same thing and is much less complex/error-prone.
if [[ "$(uname)" == "Darwin" ]]; then
    _hs_path="/Applications/Hammerspoon.app/Contents/Frameworks/hs/hs"
    if [[ -f "$_hs_path" ]]; then
        alias hs="$_hs_path"
    fi
fi
