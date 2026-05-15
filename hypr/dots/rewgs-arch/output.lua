-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- `hyprctl monitors`
--
-- NOTE: logical resolution = physical resolution / scale
-- i.e. 2400 = 3840 / 1.6 (i.e. 160% scaled)

-- Asus ProArt 6k
-- 200% looks like 3008x1692
hl.monitor({ output = "DP-2", mode = "6016x3384@59.99", position = "0x0",    scale = 2 })
-- hl.monitor({ output = "ASUSTek COMPUTER INC PA32QCV T7LMSV009353", mode = "6016x3384@59.99", position = "0x0", scale = 2 })

-- LG DualUp
-- 160% looks like 1600x1800
-- hl.monitor({ output = "DP-3", mode = "2560x2880@59.98", position = "3008x0", scale = 1.3333334 })
-- hl.monitor({ output = "DP-3", mode = "2560x2880@59.98", position = "3008x0", scale = 1.6, transform = 3 })  -- vertical
hl.monitor({ output = "DP-3", mode = "2560x2880@59.98", position = "3008x0", scale = 1.6 })
-- hl.monitor({ output = "DP-3", mode = "2560x2880@59.98", position = "3008x0", scale = 2 })
-- hl.monitor({ output = "DP-3", mode = "2560x1440@59.98", position = "3008x0", scale = 1.6 })  -- picture-in-picture mode

-- BenQ RD280OU
-- hl.monitor({ output = "DP-1", mode = "3840x2560@59.98", position = "-3840x0",  scale = 1 })
-- hl.monitor({ output = "DP-1", mode = "3840x2560@59.98", position = "-2400x0",  scale = 1.6 })  -- 160% looks like 2400x1600
-- hl.monitor({ output = "DP-1", mode = "3840x2560@59.98", position = "-1600x0",  scale = 1.6, transform = 1 })  -- vertical, 200% looks like 1600x2400
-- hl.monitor({ output = "DP-1", mode = "3840x2560@59.98", position = "-1920x0",  scale = 2 })  -- 200% looks like 1920x1280
-- hl.monitor({ output = "DP-1", mode = "3840x2560@59.98", position = "-1280x0",  scale = 2, transform = 1 })  -- vertical, 200% looks like 1280x1920
