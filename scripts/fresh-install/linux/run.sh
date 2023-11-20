# TODO: use `getopts` to parse arguments
run () {
    #
    # This function takes and runs another function.
    # On success, returns result of function.
    # On failure, exits.

    set -e

    declare -f func="$1"
    run_dir="$2"
    src_file="$3"

    cd "$run_dir" || return
    source "./$src_file"
    
    result=$func

    if [[ $exit_code -ne 0 ]]; then
        echo "An error occurred."
    else
        echo "$result"
    fi
}
