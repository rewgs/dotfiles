-- NOTE: This also moves floating windows to the top left/top right/bottom left/bottom right corners
--
-- tiled
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.move({ direction = "d" }))

-- floating (keyboard)
-- coarse
hl.bind(mainMod .. " + CTRL + ALT + h", hl.dsp.window.move({ x = -100, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + ALT + j", hl.dsp.window.move({ x = 0, y = 100, relative = true }))
hl.bind(mainMod .. " + CTRL + ALT + k", hl.dsp.window.move({ x = 0, y = -100, relative = true }))
hl.bind(mainMod .. " + CTRL + ALT + l", hl.dsp.window.move({ x = 100, y = 0, relative = true }))
-- fine
hl.bind(mainMod .. " + CTRL + ALT + SHIFT + h", hl.dsp.window.move({ x = -10, y = 0, relative = true }))
hl.bind(mainMod .. " + CTRL + ALT + SHIFT + j", hl.dsp.window.move({ x = 0, y = 10, relative = true }))
hl.bind(mainMod .. " + CTRL + ALT + SHIFT + k", hl.dsp.window.move({ x = 0, y = -10, relative = true }))
hl.bind(mainMod .. " + CTRL + ALT + SHIFT + l", hl.dsp.window.move({ x = 10, y = 0, relative = true }))

-- Floating (mouse)
-- left mouse button: 272, middle: 274, right: 273
hl.bind("mouse:274", hl.dsp.no_op()) -- disables middle-click to paste
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
