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
