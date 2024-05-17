require('mod-keys')

-- local _INFO = debug.getinfo.source:sub(2)
-- hs.alert.show(_INFO, 5)

local HYPER = mod.hyper
local SHYPER = mod.sHyper

---@type table
local SPACES, err = hs.spaces.allSpaces()
if SPACES == nil then hs.alert.show(err, 30) end

-- debug
-- for screen_uuid, space_table in pairs(SPACES) do
--     for space_id in ipairs(space_table) do
--         message = "Screen UUID: " .. screen_uuid .. "; space ID: " .. space_id
--         hs.alert.show(message, 5)
--     end
-- end

hs.hotkey.bind(HYPER, "up", function() 
    hs.spaces.toggleMissionControl() 
end)

hs.hotkey.bind(HYPER, "down", function() 
    hs.spaces.closeMissionControl() 
end)

hs.hotkey.bind(HYPER, "d", function()
    hs.spaces.toggleShowDesktop()
end)

-- NOTE: This should work, but it doesn't. Appears to be a common problem.
-- Currently binding this in System Settings/Keyboard/Keyboard Shortcuts.../Mission Control/Mission Control/Move left a space
-- hs.hotkey.bind(HYPER, "left", function()
--     local SPACE = hs.spaces.focusedSpace()
--     res, err = hs.spaces.gotoSpace(SPACE - 1)
-- end)

-- NOTE: This should work, but it doesn't. Appears to be a common problem.
-- Currently binding this in System Settings/Keyboard/Keyboard Shortcuts.../Mission Control/Mission Control/Move right a space
-- hs.hotkey.bind(HYPER, "right", function()
--     local SPACE = hs.spaces.focusedSpace()
--     res, err = hs.spaces.gotoSpace(SPACE + 1)
-- end)
