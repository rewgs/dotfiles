require('mod-keys')

hs.window.animationDuration = 0

hs.loadSpoon("WindowHalfsAndThirds")

-- Loads defualt key bindings
-- spoon.WindowHalfsAndThirds:bindHotkeys(spoon.WindowHalfsAndThirds.defaultHotkeys)

customHotkeys = {
    left_half       = { mod.hyper, "h" }, --
    right_half      = { mod.hyper, "l" }, --
    max_toggle      = { mod.hyper, "k" },

    center          = { mod.hyper, "c" }, -- retains size

    max             = { mod.hyper, "m" },

    top_half        = { mod.hyper, "t" },
    bottom_half     = { mod.hyper, "b" },
    third_up        = { mod.sHyper, "t" },
    third_down      = { mod.sHyper, "b" },

    third_left      = { mod.hyper, "[" }, -- moves *to* the left in thirds
    third_right     = { mod.hyper, "]" }, -- moves *to* the right in thirds
    middle_third_h  = { mod.hyper, "\\" },

    left_two_third  = { mod.sHyper, "h" },
    right_two_third = { mod.sHyper, "l" },

    top_left        = { mod.hyper, "u" },
    top_right       = { mod.hyper, "o" },
    bottom_left     = { mod.hyper, "m" },
    bottom_right    = { mod.hyper, "." },

    undo            = { mod.hyper, "z" },
    larger          = { mod.hyper, "w" },  -- i.e. "wider"
    smaller         = { mod.sHyper, "w" }, -- i.e. "opposite of wider"
}

spoon.WindowHalfsAndThirds:bindHotkeys(customHotkeys)
