# neovim

This neovim config dynamically matches the current machine's hostname with a config in the [`lua`](./dots/lua/) directory.

## TODO:
- Further split out config so that most of it is in a "common" section. Different machines probably don't need to deviate this much. Right now, all these configs are basically just copies of one another -- no sense in doing that.
- `setup.ps1` script for Windows machines.
