# -n turns off reverse name resolution, since you just want IP addresses. 
# On a local LAN this is probably the slowest step, too, so you get a good speed boost.
# -sn means "Don't do a port scan." It's the same as the older, deprecated -sP with the mnemonic "ping scan."
# -oG - sends "grepable" output to stdout, which gets piped to awk.
# /Up$/ selects only lines which end with "Up", representing hosts that are online.
# {print $2} prints the second whitespace-separated field, which is the IP address.
# alias lanscan="nmap -v -sn 192.168.1.0/24 -oG - | awk '/Up$/{print $2}'"
alias lanscan="/usr/bin/env python3 $DOTFILES/scripts/lanscan.py"
