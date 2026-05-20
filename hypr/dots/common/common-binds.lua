-- TODO:
-- - Super + Alt + [h|j|k|l]: if window in that direction is a Group, join the group;
--   otherwise, move window in that direction (i.e. current Super + Ctrl + [h|j|k|l]).

-- Window management
hl.bind(mainMod .. " + w", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + r", hl.dsp.exec_cmd("hyprctl reload"))

-- Terminal and launcher
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("kitty --class floaterm"))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(launcher))

-- Apps
hl.bind(mainMod .. " + e", hl.dsp.exec_cmd(fileExplorer))
hl.bind(mainMod .. " + i", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + o", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + d", hl.dsp.exec_cmd("discord"))

-- Window states
hl.bind(mainMod .. " + ALT + f", hl.dsp.window.float())
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + t", hl.dsp.layout("togglesplit")) -- dwindle; preserve_split must be enabled

-- Cycle windows
hl.bind(mainMod .. " + Tab", hl.dsp.window.cycle_next({ next = false }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.window.cycle_next())

-- Pin (must be floating)
hl.bind(mainMod .. " + p", hl.dsp.window.pin())

-- =============================================================================
-- Groups
-- =============================================================================

hl.bind(mainMod .. " + g", hl.dsp.group.toggle())
hl.bind(mainMod .. " + ALT + g", hl.dsp.window.move({ out_of_group = true }))

-- Move into group in direction
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.move({ into_group = "l" }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.move({ into_group = "d" }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.move({ into_group = "u" }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.move({ into_group = "r" }))

-- Cycle through windows within a group
hl.bind("ALT + Tab", hl.dsp.group.next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.group.prev())

-- Move window position within group (currently also used as tmux binds)
hl.bind(mainMod .. " + ALT + CTRL + l", hl.dsp.layout("movegroupwindow f"))
hl.bind(mainMod .. " + ALT + CTRL + h", hl.dsp.layout("movegroupwindow b"))

-- =============================================================================
-- Focus
-- =============================================================================

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

-- =============================================================================
-- Resize windows
-- =============================================================================

-- Coarse (note: { repeating = true } makes holding the key repeat the action)
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Fine
hl.bind(
	mainMod .. " + SHIFT + ALT + h",
	hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
	{ repeating = true }
)
hl.bind(mainMod .. " + SHIFT + ALT + l", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
hl.bind(
	mainMod .. " + SHIFT + ALT + k",
	hl.dsp.window.resize({ x = 0, y = -10, relative = true }),
	{ repeating = true }
)
hl.bind(mainMod .. " + SHIFT + ALT + j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })

-- =============================================================================
-- Move windows
-- =============================================================================

-- Tiled
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.move({ direction = "d" }))

-- Floating (keyboard)
hl.bind(mainMod .. " + CTRL + ALT + h", hl.dsp.window.move({ x = -100, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + ALT + j", hl.dsp.window.move({ x = 0, y = 100, relative = true }))
hl.bind(mainMod .. " + CTRL + ALT + k", hl.dsp.window.move({ x = 0, y = -100, relative = true }))
hl.bind(mainMod .. " + CTRL + ALT + l", hl.dsp.window.move({ x = 100, y = 0, relative = true }))

-- Floating (mouse)
-- left mouse button: 272, middle: 274, right: 273
hl.bind("mouse:274", hl.dsp.no_op()) -- disables middle-click to paste
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- =============================================================================
-- Workspaces
-- =============================================================================

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + Escape", hl.dsp.workspace.toggle_special())
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.window.move({ workspace = "special" }))

-- Switch and move to workspace (1-10 / 11-20 / 21-30 / 31-40)
for i = 1, 10 do
	local key = tostring(i % 10) -- 10 maps to "0"

	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.focus({ workspace = i + 10 }))
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.focus({ workspace = i + 20 }))
	hl.bind(mainMod .. " + CTRL + ALT + " .. key, hl.dsp.focus({ workspace = i + 30 }))

	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.bind(mainMod .. " + CTRL + SHIFT + " .. key, hl.dsp.window.move({ workspace = i + 10 }))
	hl.bind(mainMod .. " + ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = i + 20 }))
	hl.bind(mainMod .. " + CTRL + ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = i + 30 }))
end

-- Incrementally (active workspaces, skips empty)
hl.bind(mainMod .. " + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + equal", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + minus", hl.dsp.focus({ workspace = "e-1" }))

-- Incrementally (all workspaces)
hl.bind(mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + equal", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + minus", hl.dsp.focus({ workspace = "-1" }))

-- Move active window incrementally
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "-1" }))

-- Toggle waybar
hl.bind(mainMod .. " + b", hl.dsp.exec_cmd("killall waybar || waybar"))
