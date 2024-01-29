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
    { mod.hyper,  'g', function() hs.grid.toggleShow() end },

    { mod.hyper,  's', function() snapAllWindowsToGrid() end },

    -- Create new Finder window in active workspace
    -- { mod.hyper,   'f',      function() hs.application.find("Finder"):selectMenuItem({ "File", "New Finder Window" }) end },

    -- Create new terminal window in active workspace
    -- { mod.hyper,  't',      function() newWindow(TERMINAL) end },
    -- { mod.hyper,  'return', function() newWindow(TERMINAL) end },

    { mod.hyper,  'h', function() moveWindow(0, 0, 0.5, 1) end },             -- left half
    { mod.hyper,  'j', function() moveWindow(0.1, 0.1, 0.8, 0.8) end },       -- centered
    { mod.hyper,  'k', function() hs.window.focusedWindow():maximize() end }, -- maximized
    { mod.hyper,  'l', function() moveWindow(0.5, 0, 0.5, 1) end },           -- right half

    { mod.sHyper, '[', function() moveWindow(0, 0, 0.334, 1) end },           -- left 1/3
    { mod.sHyper,  '\\', function() moveWindow(0.334, 0, 0.334, 1) end },     -- middle third
    { mod.sHyper, ']', function() moveWindow(0.666, 0, 0.334, 1) end },       -- right 1/3

    { mod.sHyper, 'h', function() moveWindow(0, 0, 0.666, 1) end },           -- left 2/3
    { mod.sHyper, 'l', function() moveWindow(0.3334, 0, 0.666, 1) end },      -- right 2/3

    { mod.hyper,  'y', function() moveWindow(0, 0, 0.5, 0.5) end },           -- upper left quarter
    { mod.hyper,  'o', function() moveWindow(0.5, 0, 0.5, 0.5) end },         -- upper right quarter
    { mod.hyper,  'n', function() moveWindow(0, 0.5, 0.5, 0.5) end },         -- lower left quarter
    { mod.hyper,  '.', function() moveWindow(0.5, 0.5, 0.5, 0.5) end },       -- lower right quarter

}
for _, map in ipairs(key_bindings) do
    hs.hotkey.bind(map[1], map[2], map[3])
end

-- return key_bindings
