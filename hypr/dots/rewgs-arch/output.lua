-- LG DualUps in portrait
local y_offset = 212

-- LG DualUps in landscale
-- local y_offset = 424

-- Asus ProArt 6k (center)
hl.monitor({ output = "DP-1", mode = "6016x3384@59.99", position = "0x0", scale = 2 }) -- looks like 3008x1692

-- LG DualUp (left)
hl.monitor({ output = "DP-3", mode = "2560x2880@59.98", position = "-1920x" .. y_offset, scale = 1.3333334 }) -- looks like 1920x2160
-- hl.monitor({ output = "DP-3", mode = "2560x2880@59.98", position = "-2160x" .. y_offset, scale = 1.3333334, transform = 3, })
-- hl.monitor({ output = "DP-3", mode = "2560x2880@59.98", position = "-1800x0", scale = 1.6, transform = 3 }) -- looks like 1800x1600
-- hl.monitor({ output = "DP-3", mode = "2560x2880@59.98", position = "-1600x0", scale = 1.6 }) -- looks like 1600x1800

-- LG DualUp (right)
hl.monitor({ output = "DP-2", mode = "2560x2880@59.98", position = "3008x" .. y_offset, scale = 1.3333334 }) -- looks like 2160x1920
-- hl.monitor({ output = "DP-2", mode = "2560x2880@59.98", position = "3008x" .. y_offset, scale = 1.3333334, transform = 3, }) -- looks like 2160x1920
-- hl.monitor({ output = "DP-2", mode = "2560x2880@59.98", position = "3008x0", scale = 1.6, transform = 3 }) -- looks like 1800x1600
-- hl.monitor({ output = "DP-2", mode = "2560x2880@59.98", position = "3008x0", scale = 1.6 }) -- looks like 1800x1600
