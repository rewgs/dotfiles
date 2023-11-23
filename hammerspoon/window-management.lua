require('apps')
require('mod-keys')

hs.window.animationDuration = 0

-- @type int, int, int, int
local function moveWindow(X, Y, W, H) --> none
    local window = hs.window.focusedWindow()
    local screenFrame = window:screen():frame()

    window:setFrame({
        x = screenFrame.x + screenFrame.w * X,
        y = screenFrame.y + screenFrame.h * Y,
        w = screenFrame.w * W,
        h = screenFrame.h * H
    })
end

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

-- mapping = {{modifier, key, function}}
local key_bindings = {
    -- Create new Finder window in active workspace
    { mod.hyper,   'f',      function() hs.application.find("Finder"):selectMenuItem({ "File", "New Finder Window" }) end },

    -- Create new terminal window in active workspace
    { mod.oHyper,  't',      function() newWindow(TERMINAL) end },
    { mod.oHyper,  'return', function() newWindow(TERMINAL) end },

    -- left half
    { mod.hyper,   'h',      function() moveWindow(0, 0, 0.5, 1) end },
    { mod.hyper,   'left',   function() moveWindow(0, 0, 0.5, 1) end },

    -- left third
    { mod.oHyper,  'h',      function() moveWindow(0, 0, 0.33, 1) end },
    { mod.oHyper,  'left',   function() moveWindow(0, 0, 0.33, 1) end },

    -- left two-thirds
    { mod.soHyper, 'h',      function() moveWindow(0, 0, 0.66, 1) end },
    { mod.soHyper, 'left',   function() moveWindow(0, 0, 0.66, 1) end },

    -- right half
    { mod.hyper,   'l',      function() moveWindow(0.5, 0, 0.5, 1) end },
    { mod.hyper,   'right',  function() moveWindow(0.5, 0, 0.5, 1) end },

    -- right third
    { mod.oHyper,  'l',      function() moveWindow(0.66, 0, 0.37, 1) end },
    { mod.oHyper,  'right',  function() moveWindow(0.66, 0, 0.37, 1) end },

    -- right two-thirds
    { mod.soHyper, 'l',      function() moveWindow(0.33, 0, 0.67, 1) end },
    { mod.soHyper, 'right',  function() moveWindow(0.33, 0, 0.67, 1) end },

    -- middle third
    { mod.oHyper,  'k',      function() moveWindow(0.33, 0, 0.33, 1) end },
    { mod.oHyper,  'up',     function() moveWindow(0.33, 0, 0.33, 1) end },

    -- TODO: upper right quarter
    -- { mod.hyper,   'i',      function() moveWindow(0.5, 0, 0.5, 0.5) end },

    -- TODO: lower right quarter
    -- { mod.hyper,   'k',      function() moveWindow(0.5, 0.5, 0.5, 0.5) end },

    -- TODO: upper left quarter
    -- { mod.hyper,   'u',      function() moveWindow(0, 0, 0.5, 0.5) end },

    -- TODO: lower left quarter
    -- { mod.hyper,   'j',      function() moveWindow(0, 0.5, 0.5, 0.5) end },

    -- maximize window
    { mod.sHyper,  'm',      function() hs.window.focusedWindow():maximize() end },
    { mod.hyper,   'up',     function() hs.window.focusedWindow():maximize() end },

    -- almost maximized window
    { mod.hyper,   'm',      function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
    { mod.hyper,   'down',   function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
}

for _, map in ipairs(key_bindings) do
    hs.hotkey.bind(map[1], map[2], map[3])
end

-- return key_bindings
