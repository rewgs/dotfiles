bindkey -v
export KEYTIMEOUT=1

# places the vi mode to the left
# https://stackoverflow.com/questions/3622943/zsh-vi-mode-status-line
# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#     RPS2=$RPS1
#     zle reset-prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

# Changes cursor depending on vi mode
# i-beam: INSERT mode; block: NORMAL mode
# https://thevaluable.dev/zsh-install-configure-mouseless/
function cursor_mode {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    function zle-line-init {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}
cursor_mode
