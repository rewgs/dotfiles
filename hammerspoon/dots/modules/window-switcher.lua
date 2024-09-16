require('modules.mod-keys')

local HYPER = mod.hyper
local SHYPER = mod.sHyper


local ui_prefs = {
--     hs.window.switcher.ui.textColor = {0.9,0.9,0.9},
--     hs.window.switcher.ui.fontName = 'Lucida Grande',
--     hs.window.switcher.ui.textSize = 16, -- in screen point,
--     hs.window.switcher.ui.highlightColor = {0.8,0.5,0,0.8}, -- highlight color for the selected window 
--     hs.window.switcher.ui.backgroundColor = {0.3,0.3,0.3,1}, 
--     hs.window.switcher.ui.onlyActiveApplication = false, -- only show windows of the active application
--     hs.window.switcher.ui.showTitles = true, -- show window titles
--     hs.window.switcher.ui.titleBackgroundColor = {0,0,0},
--     hs.window.switcher.ui.showThumbnails = true, -- show window thumbnails
--     hs.window.switcher.ui.thumbnailSize = 128, -- size of window thumbnails in screen points
--     hs.window.switcher.ui.showSelectedThumbnail = true, -- show a larger thumbnail for the currently selected window
--     hs.window.switcher.ui.selectedThumbnailSize = 384,
--     hs.window.switcher.ui.showSelectedTitle = true -- show larger title for the currently selected window
}

-- default windowfilter: only visible windows, all Spaces
MAIN_SWITCHER = hs.window.switcher.new()

-- include minimized/hidden windows, current Space only
ALT_SWITCHER = hs.window.switcher.new(  hs.window.filter.new():
                                        setCurrentSpace(true):
                                        setDefaultFilter{}  ) 

-- example
-- specialized switcher for your dozens of browser windows
-- switcher_browsers = hs.window.switcher.new{'Safari','Google Chrome'} 

hs.hotkey.bind('cmd-ctrl',       'tab', 'Next window', function()MAIN_SWITCHER:next()end)
hs.hotkey.bind('cmd-ctrl-shift', 'tab', 'Prev window', function()MAIN_SWITCHER:previous()end)

hs.hotkey.bind('alt-cmd-ctrl',       'tab', 'Next window', function()ALT_SWITCHER:next()end)
hs.hotkey.bind('alt-cmd-ctrl-shift', 'tab', 'Prev window', function()ALT_SWITCHER:previous()end)

-- alternatively, call .nextWindow() or .previousWindow() directly (same as hs.window.switcher.new():next())
-- hs.hotkey.bind('cmd-ctrl', 'tab', 'Next window',hs.window.switcher.nextWindow)

-- you can also bind to `repeatFn` for faster traversing
-- hs.hotkey.bind('cmd-ctrl-shift', 'tab', 'Prev window', hs.window.switcher.previousWindow,nil,hs.window.switcher.previousWindow)
-- hs.hotkey.bind('cmd-ctrl-shift', 'tab', 'Prev window', hs.window.switcher.previousWindow)
