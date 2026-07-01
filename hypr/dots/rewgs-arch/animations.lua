-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

---@type boolean
local enabled = true

---@type number
local speed = 1.5

hl.config({
	animations = {
		enabled = true,
	},
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/#animation-tree

-- hl.animation({ leaf = "windows", enabled = enabled, speed = speed, bezier = "myBezier" })
hl.animation({ leaf = "windows", enabled = enabled, speed = speed, bezier = "default" })
hl.animation({ leaf = "windowsOut", enabled = enabled, speed = speed, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = enabled, speed = speed, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = enabled, speed = speed, bezier = "default" })
hl.animation({ leaf = "fade", enabled = enabled, speed = speed, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = enabled, speed = speed, bezier = "default" })
