if command -v com.protonvpn.www &> /dev/null; then
    # Runs in background, and avoids creating a `nohup.out` file.
    alias protonvpn="nohup com.protonvpn.www >& /dev/null &"
fi
