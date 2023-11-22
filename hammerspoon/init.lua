require('reload')

local hyper = { 'cmd', 'ctrl' }
local sHyper = { 'cmd', 'ctrl', 'shift' }
local oHyper = { 'cmd', 'ctrl', 'option' }
local soHyper = { 'cmd', 'ctrl', 'option', 'shift' }

hs.window.animationDuration = 0

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
local function newWindow(application) --> @type none
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
    { key = 'd',      app = 'Discord' }, -- would like to key-chord this so that hyper+m,{something} calls different messaging apps, e.g. hyper+m,d calls Discord
    { key = 'f',      app = 'Finder' },
    { key = 't',      app = TERMINAL },
    { key = 'return', app = TERMINAL }
}
for _, map in ipairs(app_maps) do
    hs.hotkey.bind(hyper, map.key,
        function()
            hs.application.launchOrFocus(map.app)
        end
    )
end

-- mapping = {{modifier, key, function}}
local key_maps = {
    -- Create new Finder window in active workspace
    { hyper,  'f',      function() hs.application.find("Finder"):selectMenuItem({ "File", "New Finder Window" }) end },

    -- Create new terminal window in active workspace
    { sHyper, 't',      function() newTerminal() end },
    { sHyper, 'return', function() newTerminal() end },

    -- left half
    { hyper,  'h',      function() moveWindow(0, 0, 0.5, 1) end },
    { hyper,  'left',   function() moveWindow(0, 0, 0.5, 1) end },

    -- left third
    { sHyper,  'h',      function() moveWindow(0, 0, 0.3, 1) end },
    { sHyper,  'left',   function() moveWindow(0, 0, 0.3, 1) end },

    -- left two-thirds
    { soHyper,  'h',      function() moveWindow(0, 0, 0.6, 1) end },
    { soHyper,  'left',   function() moveWindow(0, 0, 0.6, 1) end },

    -- right half
    { hyper,  'l',      function() moveWindow(0.5, 0, 0.5, 1) end },
    { hyper,  'right',  function() moveWindow(0.5, 0, 0.5, 1) end },

    -- right third
    { sHyper,  'l',      function() moveWindow(0.6, 0, 0.4, 1) end },
    { sHyper,  'right',   function() moveWindow(0.6, 0, 0.4, 1) end },

    -- right two-thirds
    { soHyper,  'l',      function() moveWindow(0.3, 0, 0.7, 1) end },
    { soHyper,  'right',   function() moveWindow(0.3, 0, 0.7, 1) end },

    -- upper right quarter
    { hyper,  'i',      function() moveWindow(0.5, 0, 0.5, 0.5) end },

    -- lower right quarter
    { hyper,  'k',      function() moveWindow(0.5, 0.5, 0.5, 0.5) end },

    -- upper left quarter
    { hyper,  'u',      function() moveWindow(0, 0, 0.5, 0.5) end },

    -- lower left quarter
    { hyper,  'j',      function() moveWindow(0, 0.5, 0.5, 0.5) end },

    -- Maximize window
    { sHyper,  'm',     function() hs.window.focusedWindow():maximize() end },
    { hyper,  'up',     function() hs.window.focusedWindow():maximize() end },

    -- Almost maximized window
    { hyper,  'm',   function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
    { hyper,  'down',   function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
}
for _, map in ipairs(key_maps) do
    hs.hotkey.bind(map[1], map[2], map[3])
end
