[`main.py`](./main.py) is executed by my [`kanshi config`](../../kanshi/dots/config), with the relevant profile's name as an argument.

This then swaps various apps' configs as defined by the profile name. Typically font sizes are just changed to account for a different display resolution, but other changes might be made as well.

## TODO:

- Kill and/or start things as needed to get this to switch automatically -- waybar, etc
- Read kanshi config for names, enable tab-to-complete for kanshi_profile
