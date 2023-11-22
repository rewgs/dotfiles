# tailscale
if [[ $(uname) == "Darwin" ]]; then
    alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

alias tshosts=tailscale_get_magic_dns_hostnames
