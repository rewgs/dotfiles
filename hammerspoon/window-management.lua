-- require('apps')
require('mod-keys')

hs.window.animationDuration = 0

hs.loadSpoon("WindowHalfsAndThirds")

-- Loads defualt key bindings
-- spoon.WindowHalfsAndThirds:bindHotkeys(spoon.WindowHalfsAndThirds.defaultHotkeys)

customHotkeys = {
    left_half    = { mod.hyper, "h" }, --*
    right_half   = { mod.hyper, "l" }, --*
    max_toggle   = { mod.hyper, "k" },
    center       = { mod.hyper, "j" },

    max          = { mod.hyper, "m" },

    top_half     = { mod.hyper, "i" },
    bottom_half  = { mod.hyper, "," },

    third_left   = { mod.sHyper, "h" }, -- moves *to* the left in thirds
    third_right  = { mod.sHyper, "l" }, -- moves *to* the right in thirds
    third_up     = { mod.sHyper, "k" },
    third_down   = { mod.sHyper, "j" },

    top_left     = { mod.hyper, "y" },
    top_right    = { mod.hyper, "o" },
    bottom_left  = { mod.hyper, "n" },
    bottom_right = { mod.hyper, "." },

    undo         = { mod.hyper, "z" },
    larger       = { mod.hyper, "w" }, -- i.e. "wider"
    smaller      = { mod.sHyper, "w" }, -- i.e. "opposite of wider"
}

spoon.WindowHalfsAndThirds:bindHotkeys(customHotkeys)
