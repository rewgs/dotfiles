require('reload')

local SUPER = { 'ctrl', 'cmd' }
local S_SUPER = { 'shift', 'ctrl', 'cmd' }

local function moveWindow(X, Y, W, H)
    local window = hs.window.focusedWindow()
    local screenFrame = window:screen():frame()
    window:setFrame({
        x = screenFrame.x + screenFrame.w * X,
        y = screenFrame.y + screenFrame.h * Y,
        w = screenFrame.w * W,
        h = screenFrame.h * H
    })
end

local function newTerminal()
    local application = hs.application.get('iTerm2')
    if application then
        application:activate(false)
        hs.eventtap.keyStroke({ 'cmd' }, 'N')
    else
        hs.application.launchOrFocus('iTerm2')
    end
end

-- adapts the above function, generalizes it
-- @type string
local function new_window(application) --> @type none
    local app = hs.application.get(application)
    if app then
        app:activate(false)
        hs.eventtap.keyStroke({ 'cmd' }, 'N')
    else
        hs.application.launchOrFocus(application)
    end
end


local TERMINAL = 'iTerm'
local BROWSER = 'Google Chrome'
local app_maps = {
    { key = 'b',      app = BROWSER },
    { key = 'c',      app = 'Visual Studio Code' },
    { key = 'd',      app = 'Discord' }, -- would like to key-chord this so that super+m,{something} calls different messaging apps, e.g. super+m,d calls Discord
    { key = 'f',      app = 'Finder' },
    { key = 't',      app = TERMINAL },
    { key = 'return', app = TERMINAL }
}
for _, map in ipairs(app_maps) do
    hs.hotkey.bind(SUPER, map.key,
        function()
            hs.application.launchOrFocus(map.app)
        end
    )
end

-- mapping = {{modifier, key, function}}
local key_maps = {
    -- Create new Finder window in active workspace
    { SUPER,  'f',      function() hs.application.find("Finder"):selectMenuItem({ "File", "New Finder Window" }) end },

    -- Create new terminal window in active workspace
    { S_SUPER, 't',      function() newTerminal() end },
    { S_SUPER, 'return', function() newTerminal() end },

    -- Move window to the left
    { SUPER,  'h',      function() moveWindow(0, 0, 0.5, 1) end },
    { SUPER,  'left',   function() moveWindow(0, 0, 0.5, 1) end },

    -- Move window to the right
    { SUPER,  'l',      function() moveWindow(0.5, 0, 0.5, 1) end },
    { SUPER,  'right',  function() moveWindow(0.5, 0, 0.5, 1) end },

    -- Move window to upper right
    { SUPER,  'i',      function() moveWindow(0.5, 0, 0.5, 0.5) end },

    -- Move window to lower right
    { SUPER,  'k',      function() moveWindow(0.5, 0.5, 0.5, 0.5) end },

    -- Move window to upper left
    { SUPER,  'u',      function() moveWindow(0, 0, 0.5, 0.5) end },

    -- Move window to lower left
    { SUPER,  'j',      function() moveWindow(0, 0.5, 0.5, 0.5) end },

    -- Maximize window
    { SUPER,  'p',      function() hs.window.focusedWindow():maximize() end },
    { SUPER,  'up',     function() hs.window.focusedWindow():maximize() end },

    -- Almost maximized window
    { SUPER,  'm',      function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
    { SUPER,  'down',   function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
}
for _, map in ipairs(key_maps) do
    hs.hotkey.bind(map[1], map[2], map[3])
end
