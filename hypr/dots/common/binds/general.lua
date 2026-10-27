hl.bind(mainMod .. " + SHIFT + r", hl.dsp.exec_cmd("hyprctl reload")) -- reload hyprland

-- Window management
hl.bind(mainMod .. " + w", hl.dsp.window.close()) -- close window

-- Terminal and launcher
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty --class floaterm"))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(launcher))

-- Window states
hl.bind(mainMod .. " + ALT + f", hl.dsp.window.float())
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Layouts
hl.bind(mainMod .. " + t", hl.dsp.layout("togglesplit")) -- dwindle; preserve_split must be enabled

-- Cycle windows
hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.window.cycle_next())

-- Pin (must be floating)
hl.bind(mainMod .. " + p", hl.dsp.window.pin())
