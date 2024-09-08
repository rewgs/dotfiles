[init](./init.lua) is called by the [global Hammerspoon init file](../init.lua); this in turn calls everything within this directory:
- [apps](./apps.lua) defines key bindings to open or focus applications.
- The files within the [custom_bindings](./custom_bindings/) directory define custom binding overrides for specific apps. As usual, this directory contains an [init](./custom_bindings/init.lua) files that calls all other files in the directory; therefore, the [applications init file](./init.lua) need only call the [custom_bindings init file](./custom_bindings/init.lua).
