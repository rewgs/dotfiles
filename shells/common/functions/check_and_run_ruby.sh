check_and_run_ruby() {
    local rb_file="$1"
    local result
    result="$(ruby -cw "$rb_file")"
    # TODO: if result passes, run the file
}
