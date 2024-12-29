require("modules.mod-keys")

hs.loadSpoon("WindowHalfsAndThirds")

hs.window.animationDuration = 0

-- Loads defualt key bindings
-- spoon.WindowHalfsAndThirds:bindHotkeys(spoon.WindowHalfsAndThirds.defaultHotkeys)

local customHotkeys = {
	left_half = { mod.hyper, "h" }, --
	right_half = { mod.hyper, "l" }, --
	max_toggle = { mod.hyper, "k" },

	center = { mod.hyper, "c" }, -- retains size

	-- max             = { mod.hyper, "m" },

	top_half = { mod.oHyper, "t" },
	bottom_half = { mod.oHyper, "b" },
	third_up = { mod.soHyper, "t" },
	third_down = { mod.soHyper, "b" },

	third_left = { mod.oHyper, "h" }, -- moves *to* the left in thirds
	third_right = { mod.oHyper, "l" }, -- moves *to* the right in thirds
	middle_third_h = { mod.oHyper, "k" },

	left_two_third = { mod.soHyper, "h" },
	right_two_third = { mod.soHyper, "l" },

	top_left = { mod.hyper, "u" },
	top_right = { mod.hyper, "o" },
	bottom_left = { mod.hyper, "m" },
	bottom_right = { mod.hyper, "." },

	undo = { mod.soHyper, "z" },
	larger = { mod.soHyper, "w" }, -- i.e. "wider"
	smaller = { mod.soHyper, "w" }, -- i.e. "opposite of wider"
}

spoon.WindowHalfsAndThirds:bindHotkeys(customHotkeys)
