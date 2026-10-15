-- TODO:
-- - Super + Alt + [h|j|k|l]: if window in that direction is a Group, join the group;
--   otherwise, move window in that direction (i.e. current Super + Ctrl + [h|j|k|l]).

hl.bind(mainMod .. " + g", hl.dsp.group.toggle())
hl.bind(mainMod .. " + ALT + g", hl.dsp.window.move({ out_of_group = true }))

-- Move into group in direction
hl.bind(mainMod .. " + ALT + h", hl.dsp.window.move({ into_group = "l" }))
hl.bind(mainMod .. " + ALT + j", hl.dsp.window.move({ into_group = "d" }))
hl.bind(mainMod .. " + ALT + k", hl.dsp.window.move({ into_group = "u" }))
hl.bind(mainMod .. " + ALT + l", hl.dsp.window.move({ into_group = "r" }))

-- Cycle through windows within a group
hl.bind("ALT + Tab", hl.dsp.group.next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.group.prev())

-- Move window position within group (currently also used as tmux binds)
hl.bind(mainMod .. " + ALT + CTRL + l", hl.dsp.group.move_window())
hl.bind(mainMod .. " + ALT + CTRL + h", hl.dsp.group.move_window({ forward = false }))
