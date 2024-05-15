# First checks the file. If no errors, runs it.

function check_and_run_ruby::main() {
    local rb_file="$1"
    local result="ruby -cw ${rb_file}" # Checks the file
    
    # TODO: if result passes, run the file
}
# check_and_run_ruby::main "$1"
