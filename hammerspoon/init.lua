require('reload')

-- local mod1 = { 'shift', 'cmd' }
local SUPER = { 'ctrl', 'cmd' }
-- local mod3 = { 'rightcmd', 'rightalt' }
-- local mod4 = { 'shift', 'ctrl', 'cmd' }

-- local function moveWindow(X, Y, W, H)
--     local window = hs.window.focusedWindow()
--     local screenFrame = window:screen():frame()
--     window:setFrame({
--         x = screenFrame.x + screenFrame.w * X,
--         y = screenFrame.y + screenFrame.h * Y,
--         w = screenFrame.w * W,
--         h = screenFrame.h * H
--     })
-- end

-- local function newTerminal()
--     local application = hs.application.get('iTerm2')
--     if application then
--         application:activate(false)
--         hs.eventtap.keyStroke({ 'cmd' }, 'N')
--     else
--         hs.application.launchOrFocus('iTerm2')
--     end
-- end

local TERMINAL = 'iTerm'
local BROWSER = 'Google Chrome'
local app_maps = {
    { key = 'c', app = 'Visual Studio Code' },
    { key = 'b', app = BROWSER },
    { key = 'd', app = 'Discord' }, -- would like to key-chord this so that super+m,{something} calls different messaging apps, e.g. super+m,d calls Discord
    { key = 't', app = TERMINAL },
}

for _, map in ipairs(app_maps) do
    hs.hotkey.bind(SUPER, map.key, function() hs.application.launchOrFocus(map.app) end)
end

-- mapping = {{modifier, key, function}}
-- local mappings = {
-- Create new Finder window in active workspace
-- { mod1, 'F',      function() hs.application.find("Finder"):selectMenuItem({ "Fichier", "Nouvelle fenêtre Finder" }) end },
-- { SUPER, 'F',      function() hs.application.find("Finder"):selectMenuItem({ "Fichier", "Nouvelle fenêtre Finder" }) end },
-- { mod3, 'F',      function() hs.application.find("Finder"):selectMenuItem({ "Fichier", "Nouvelle fenêtre Finder" }) end },

-- Move window to the left
-- { SUPER, 'H',      function() moveWindow(0, 0, 0.5, 1) end },
-- { SUPER, 'left',   function() moveWindow(0, 0, 0.5, 1) end },

-- Move window to the right
-- { SUPER, 'L',      function() moveWindow(0.5, 0, 0.5, 1) end },
-- { SUPER, 'right',  function() moveWindow(0.5, 0, 0.5, 1) end },

-- Move window to upper right
-- { SUPER, 'I',      function() moveWindow(0.5, 0, 0.5, 0.5) end },

-- Move window to lower right
-- { SUPER, 'K',      function() moveWindow(0.5, 0.5, 0.5, 0.5) end },

-- Move window to upper left
-- { SUPER, 'U',      function() moveWindow(0, 0, 0.5, 0.5) end },

-- Move window to lower left
-- { SUPER, 'J',      function() moveWindow(0, 0.5, 0.5, 0.5) end },

-- Maximize window
-- { SUPER, 'P',      function() hs.window.focusedWindow():maximize() end },
-- { SUPER, 'up',     function() hs.window.focusedWindow():maximize() end },

-- Almost maximized window
-- { SUPER, 'M',      function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
-- { SUPER, 'down',   function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
-- }
-- for _, map in ipairs(mappings) do
--     hs.hotkey.bind(map[1], map[2], map[3])
-- end
