-- local mod_keys = require('mod-keys')
-- require('mod-keys')
-- local utils = require('utils')

-- local HYPER = mod.hyper
-- local SHYPER = mod.sHyper

-- local DISPLAYS = {"yabai", "--message", "query", "--displays"}
-- local SPACES = {"yabai", "--message", "query", "--spaces"}
-- local WINDOWS = {"yabai", "--message", "query", "--windows"}

-- local SELECTED_DISPLAY = utils.copy_array(DISPLAYS).insert("--display")
-- local SELECTED_SPACE = utils.copy_array(SPACES).insert("--space")
-- local SELECTED_WINDOW = utils.copy_array(WINDOWS).insert("--window")


-- local bindings = {
    -- { mod = HYPER, key = 'p', command = { "yabai", "--message", "window", "--focus", "prev"} }

--     focus_prev_window = { 
--         modkey = HYPER, 
--         key = "p", 
--         command = { "yabai", "--message", "window", "--focus", "prev"}
--     },
--     focus_next_window = { 
--         modkey = HYPER, 
--         key = "n", 
--         command = { "yabai", "--message", "window", "--focus", "next"}
--     },
--     focus_west = {
--         modkey = HYPER,
--         key = "h",
--         command = { "yabai", "--message", "window", "--focus", "west" }
--     },
--     focus_south = {
--         modkey = HYPER,
--         key = "j",
--         command = { "yabai", "--message", "window", "--focus", "south" }
--     },
--     focus_north = {
--         modkey = HYPER,
--         key = "k",
--         command = { "yabai", "--message", "window", "--focus", "north" }
--     },
--     focus_south = {
--         modkey = HYPER,
--         key = "l",
--         command = { "yabai", "--message", "window", "--focus", "south" }
--     },
-- }


-- local function bind_keys(kbs)
--     for _, b in ipairs(kbs) do
--         hs.hotkey.bind(b.modkey, b.key, 
--             function() 
--                 -- output:  the stdout of the command as a string. May contain an 
--                 --          extra terminating new-line (\n).
--                 -- status:  true if the command terminated successfully or nil otherwise.
--                 -- type:    a string value of "exit" or "signal" indicating whether the command terminated 
--                 --          of its  own accord or if it was terminated by a signal (killed, segfault, etc).
--                 -- rc:      if the command exited of its own accord, then this number will represent the exit 
--                 --          code (usually 0 for success, not 0 for an error, though this is very command 
--                 --          specific, so check man pages when there is a question). If the command was 
--                 --          killed by a signal, then this number corresponds to the signal type that caused 
--                 --          the command to terminate.
--                 -- output, status, type, rc = hs.execute(b.command)
--                 -- hs.execute(b.command)
--                 -- if status then return end
--             end
--         )
--     end
-- end
-- bind_keys(bindings)
