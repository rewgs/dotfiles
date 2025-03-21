require("modules.mod-keys")

hs.loadSpoon("WindowHalfsAndThirds")

hs.window.animationDuration = 0

-- Loads defualt key bindings
-- spoon.WindowHalfsAndThirds:bindHotkeys(spoon.WindowHalfsAndThirds.defaultHotkeys)

local customHotkeys = {
	left_half = { Mod.hyper, "h" }, --
	right_half = { Mod.hyper, "l" }, --
	max_toggle = { Mod.hyper, "k" },

	-- center = { Mod.hyper, "c" }, -- retains size

	-- max             = { mod.hyper, "m" },

	top_half = { Mod.oHyper, "t" },
	bottom_half = { Mod.oHyper, "b" },
	third_up = { Mod.soHyper, "t" },
	third_down = { Mod.soHyper, "b" },

	third_left = { Mod.oHyper, "h" }, -- moves *to* the left in thirds
	third_right = { Mod.oHyper, "l" }, -- moves *to* the right in thirds
	middle_third_h = { Mod.oHyper, "k" },

	left_two_third = { Mod.soHyper, "h" },
	right_two_third = { Mod.soHyper, "l" },

	top_left = { Mod.hyper, "u" },
	top_right = { Mod.hyper, "p" },
	bottom_left = { Mod.sHyper, "," }, -- <
	bottom_right = { Mod.sHyper, "." }, -- >

	undo = { Mod.soHyper, "z" },
	larger = { Mod.soHyper, "w" }, -- i.e. "wider"
	smaller = { Mod.soHyper, "w" }, -- i.e. "opposite of wider"
}

spoon.WindowHalfsAndThirds:bindHotkeys(customHotkeys)
