# Brightness for Pro Display XDR va asdcontrol
if [[ "$(uname)" == "Linux" ]]; then
    alias br="sudo asdcontrol /dev/usb/hiddev7"
    alias bu="sudo asdcontrol /dev/usb/hiddev7 -- +$1"
    alias bd="sudo asdcontrol /dev/usb/hiddev7 -- -$1"
fi
