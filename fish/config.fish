if status is-interactive
    # Commands to run in interactive sessions can go here
end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/rewgs/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
