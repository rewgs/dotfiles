# tailscale
if [[ $(uname) == "Darwin" ]] && \
[[ ! -f "$HOME/go/bin/tailscale" ]] && \
[[ -f "/Applications/Tailscale.app/Contents/MacOS/Tailscale" ]]; then
    alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

alias tshosts=tailscale_get_magic_dns_hostnames
