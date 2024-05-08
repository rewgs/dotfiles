lanscan () {
    get_online_machines () {
        # echo "Running get_online_machines()..."
    # local online_machines=$(nmap -v -sn 192.168.1.0/24 -oG - | awk '/Up$/{print $2}')
        local all_machines="$1"
        # echo "$all_machines"
        for machine in $all_machines; do
            echo "$machine"
        done
    }


    get_longest_line_length () {
        # Returns the length of the longest online machine entry.
        local longest_line=0
        for machine in "$online_machines"; do
            length=${#machine}
            if [[ $length > $longest_line ]]; then
                $longest_line=$length
            fi
        done
        echo $longest_line
    }


    get_offset () {
        # Returns
        local longest_line = ${#1}
        local line_length = ${#2}
    }


    echo_loop () {
        local online_machines=$1
        for machine in "$online_machines"; do
            echo "$machine"
        done
    }



    # re-match the machine with its entry length
    # for machine in "$online_machines"; do
    #     if [[ ${#machine}} == $longest_line ]]; then
    #         # TODO: something with $machine
    #     fi
    # done

    main () {
        echo "Scanning LAN..."

        # -n turns off reverse name resolution, since you just want IP addresses. On a local LAN this is probably the slowest step, too, so you get a good speed boost.
        # -sn means "Don't do a port scan." It's the same as the older, deprecated -sP with the mnemonic "ping scan."
        # -oG - sends "grepable" output to stdout, which gets piped to awk.
        # /Up$/ selects only lines which end with "Up", representing hosts that are online.
        # {print $2} prints the second whitespace-separated field, which is the IP address.
        # local online_machines=$(nmap -v -sn 192.168.1.0/24 -oG - | awk '/Up$/{print $2}')
        # local all_machines=$(nmap -v -sn 192.168.1.0/24 -oG -)
        local all_machines=$(nmap -v -sn 192.168.1.0/24)
        # echo "$all_machines"
        # local online_machines=$(get_online_machines "$all_machines")
        get_online_machines "$all_machines"
        # echo "$online_machines"
        # echo_loop "$online_machines"
    }
    main
}
lanscan
