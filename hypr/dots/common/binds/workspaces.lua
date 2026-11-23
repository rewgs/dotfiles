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

-- Move window to next empty workspace
hl.bind(mainMod .. " + CTRL + SHIFT + equal", hl.dsp.window.move({ workspace = "emptyn" }))

-- Switch back to last used workspace
hl.bind(mainMod .. " + grave", hl.dsp.focus({ workspace = "previous" }))

-- FIXME: Triggering this crashes Hyprland!
-- Renames the current workspace
-- hl.bind(mainMod .. " + r", function()
-- 	local handle = io.popen("fuzzel --dmenu -p 'Rename workspace:' </dev/null 2>/dev/null")
-- 	if handle then
-- 		local name = handle:read("*l")
-- 		handle:close()
-- 		if name and name ~= "" then
-- 			hl.dispatch(hl.dsp.workspace.rename(name))
-- 		end
-- 	end
-- end)
