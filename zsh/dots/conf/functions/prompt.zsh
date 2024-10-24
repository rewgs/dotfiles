# Original source: https://github.com/Phantas0s/purification/blob/master/prompt_purification_setup

# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)

# Display git status
# Might be faster using ripgrep too
prompt::git-status() {
  local INDEX STATUS

  INDEX=$(command git status --porcelain -b 2> /dev/null)

  STATUS=""

  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED"
  fi

  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED"
  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED"
  elif $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED"
  fi

  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED"
  elif $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED"
  fi

  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED"
  fi

  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED"
  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED"
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED"
  fi

  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_STASHED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_STASHED"
  fi

  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi

  if $(echo "$INDEX" | grep '^## [^ ]\+ .*ahead' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi

  if $(echo "$INDEX" | grep '^## [^ ]\+ .*behind' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi

  if $(echo "$INDEX" | grep '^## [^ ]\+ .*diverged' &> /dev/null); then
    # STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
    STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi

  if [[ ! -z "$STATUS" ]]; then
    # echo " [ $STATUS]"
    echo " $STATUS"
  fi
}


prompt::git-branch() {
    autoload -Uz vcs_info 
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )
    setopt prompt_subst
    zstyle ':vcs_info:git:*' formats '%b'
}

prompt::git-info() {
    # [ ! -z "$vcs_info_msg_0_" ] && echo "$ZSH_THEME_GIT_PROMPT_PREFIX%F{white}$vcs_info_msg_0_%f$ZSH_THEME_GIT_PROMPT_SUFFIX"
    # [ ! -z "$vcs_info_msg_0_" ] && echo "%F{magenta}git:($vcs_info_msg_0_%f$ZSH_THEME_GIT_PROMPT_SUFFIX)"
    [ ! -z "$vcs_info_msg_0_" ] && echo "%F{magenta}git:(%f%F{red}$vcs_info_msg_0_%f$ZSH_THEME_GIT_PROMPT_SUFFIX%F{magenta})%f"
}

prompt::precmd() {
    # Pass a line before each prompt
    print -P ''
}

prompt::main() {
    # Display git branch

    # autoload -Uz add-zsh-hook
    # add-zsh-hook precmd prompt::precmd

    # ZSH_THEME_GIT_PROMPT_PREFIX=" %F{red}λ%f:"
    # ZSH_THEME_GIT_PROMPT_PREFIX=" %F{red}%f"
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    # original
    # ZSH_THEME_GIT_PROMPT_ADDED="%F{green}+%f "
    # ZSH_THEME_GIT_PROMPT_MODIFIED="%F{blue}%f "
    # ZSH_THEME_GIT_PROMPT_DELETED="%F{red}x%f "
    # ZSH_THEME_GIT_PROMPT_RENAMED="%F{magenta}➜%f "
    # ZSH_THEME_GIT_PROMPT_UNMERGED="%F{yellow}═%f "
    # ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{white}%f "
    # ZSH_THEME_GIT_PROMPT_STASHED="%F{red}%f "
    # ZSH_THEME_GIT_PROMPT_BEHIND="%F{red}%f "
    # ZSH_THEME_GIT_PROMPT_AHEAD="%F{green}%f "

    # my edits
    ZSH_THEME_GIT_PROMPT_ADDED="%F{green}+%f"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%F{blue}%f"
    ZSH_THEME_GIT_PROMPT_DELETED="%F{red}x%f"
    ZSH_THEME_GIT_PROMPT_RENAMED="%F{magenta}➜%f"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%F{yellow}═%f"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{white}%f"
    ZSH_THEME_GIT_PROMPT_STASHED="%F{red}%f"
    ZSH_THEME_GIT_PROMPT_BEHIND="%F{red}%f"
    ZSH_THEME_GIT_PROMPT_AHEAD="%F{green}%f"

    # original
    # prompt::git-branch
    # RPROMPT='$(prompt::git-info) $(prompt::git-status)'
    # PROMPT=$'%F{white}%~ %B%F{blue}>%f%b '

    # my edit
    prompt::git-branch
    # RPROMPT='$(prompt::git-info)'
    # PROMPT=$'%B➜ %F{white}%~ $(prompt::git-info) %F{blue}~%f%b '
    # PROMPT=$'%B%F{green}➜%f %F{blue}%~ $(prompt::git-info)$(prompt::git-status)%b '
    PROMPT=$'%B%F{green}➜%f %F{blue}%~ $(prompt::git-info)%b '
}
prompt::main
