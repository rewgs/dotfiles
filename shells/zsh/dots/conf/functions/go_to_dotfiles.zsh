# zsh tab-completion handler for go_to_dotfiles (defined in shell/functions/go_to_dotfiles.sh)
function _go_to_dotfiles() {
    local state cur context line

    local dirs=$(ls -d $DOTFILES/*)
    for dir in "${dirs[@]}"; do
        echo "$dir"
    done
}
