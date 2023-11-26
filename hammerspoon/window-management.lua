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

-- Doesn't really work yet. Needs to:
-- 1. Get coordinates of all windows.
-- 2. Cycle through all grids (clockwise, I guess?)
-- 3. Move the window with coordinates closest to the current grid box to it.
local function snapAllWindowsToGrid()
    -- @type table
    local visibleWindows = hs.window.visibleWindows()

    for _, window in ipairs(visibleWindows) do
        hs.grid.snap(window) --> hs.grid
    end
end

-- TODO: add resizing of windows, make mod.sHyper+[h|j|k|l]
-- mapping = {{modifier, key, function}}
local key_bindings = {
    -- Effectively toggles between running hs.grid.show() when the grid is
    -- hidden, and hs.grid.hide() when the grid is visible.
    { mod.hyper,   'g',      function() hs.grid.toggleShow() end },

    { mod.hyper,   's',      function() snapAllWindowsToGrid() end },

    -- Create new Finder window in active workspace
    -- { mod.hyper,   'f',      function() hs.application.find("Finder"):selectMenuItem({ "File", "New Finder Window" }) end },

    -- Create new terminal window in active workspace
    -- { mod.hyper,  't',      function() newWindow(TERMINAL) end },
    -- { mod.hyper,  'return', function() newWindow(TERMINAL) end },

    -- left half
    { mod.hyper,   'h',      function() moveWindow(0, 0, 0.5, 1) end },
    { mod.hyper,   'left',   function() moveWindow(0, 0, 0.5, 1) end },

    -- FIXME: conflicting with left half
    -- left third
    -- { mod.hyper,  'h',      function() moveWindow(0, 0, 0.334, 1) end },
    -- { mod.hyper,  'left',   function() moveWindow(0, 0, 0.334, 1) end },

    -- left two-thirds
    -- { mod.sHyper, 'h',      function() moveWindow(0, 0, 0.666, 1) end },
    -- { mod.sHyper, 'left',   function() moveWindow(0, 0, 0.666, 1) end },

    -- right half
    { mod.hyper,   'l',      function() moveWindow(0.5, 0, 0.5, 1) end },
    { mod.hyper,   'right',  function() moveWindow(0.5, 0, 0.5, 1) end },

    -- FIXME: conflicting with right half
    -- right third
    -- { mod.hyper,  'l',      function() moveWindow(0.666, 0, 0.334, 1) end },
    -- { mod.hyper,  'right',  function() moveWindow(0.666, 0, 0.334, 1) end },

    -- right two-thirds
    -- { mod.sHyper, 'l',      function() moveWindow(0.3334, 0, 0.666, 1) end },
    -- { mod.sHyper, 'right',  function() moveWindow(0.3334, 0, 0.666, 1) end },

    -- FIXME: conflicting with maximize
    -- middle third
    -- { mod.hyper,  'k',      function() moveWindow(0.334, 0, 0.334, 1) end },
    -- { mod.hyper,  'up',     function() moveWindow(0.334, 0, 0.334, 1) end },

    -- TODO: upper right quarter
    -- { mod.hyper,   'i',      function() moveWindow(0.5, 0, 0.5, 0.5) end },

    -- TODO: lower right quarter
    -- { mod.hyper,   'k',      function() moveWindow(0.5, 0.5, 0.5, 0.5) end },

    -- TODO: upper left quarter
    -- { mod.hyper,   'u',      function() moveWindow(0, 0, 0.5, 0.5) end },

    -- TODO: lower left quarter
    -- { mod.hyper,   'j',      function() moveWindow(0, 0.5, 0.5, 0.5) end },

    -- maximize window
    { mod.hyper,   'k',      function() hs.window.focusedWindow():maximize() end },
    { mod.sHyper,  'm',      function() hs.window.focusedWindow():maximize() end },
    { mod.hyper,   'up',     function() hs.window.focusedWindow():maximize() end },

    -- almost maximized window
    { mod.hyper,   'j',      function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
    -- { mod.hyper,   'm',      function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
    { mod.hyper,   'down',   function() moveWindow(0.1, 0.1, 0.8, 0.8) end },
}

for _, map in ipairs(key_bindings) do
    hs.hotkey.bind(map[1], map[2], map[3])
end

-- return key_bindings
