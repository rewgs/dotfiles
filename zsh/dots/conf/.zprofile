# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ about this file                                                            ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# .zprofile is for login shells. It is basically the same as .zlogin except that it's sourced 
# before .zshrc whereas .zlogin is sourced after .zshrc. According to the zsh documentation, 
# ".zprofile is meant as an alternative to .zlogin for ksh fans; the two are not intended to be 
# used together, although this could certainly be done if desired."

LS_COLORS="ow=01;93;40:ln=00;35;40:ex=00;31;40:*.mp3=00;32;40:*.wav=00;32;40:*.aif=00;32;40:*.aiff=00;32;40"
export LS_COLORS

# homebrew
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# Note that the instructions above specifically state to put this in .zprofile 
# for macOS, and .zshrc for Linux.
if [[ "$(uname)" == "Darwin" ]]; then
    # NOTE: Can't use smartcache for some reason.
    eval "$(brew shellenv)"
fi
