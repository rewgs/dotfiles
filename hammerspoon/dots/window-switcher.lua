-- default windowfilter: only visible windows, all Spaces
switcher = hs.window.switcher.new() 
switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{}) -- include minimized/hidden windows, current Space only

-- example
-- specialized switcher for your dozens of browser windows
-- switcher_browsers = hs.window.switcher.new{'Safari','Google Chrome'} 

hs.window.switcher.ui

-- bind to hotkeys; NOTE: at least one modifier key is required!
hs.hotkey.bind('alt','tab', 'Next window', function()switcher:next()end)
hs.hotkey.bind('alt-shift', 'tab','Prev window', function()switcher:previous()end)

-- alternatively, call .nextWindow() or .previousWindow() directly (same as hs.window.switcher.new():next())
hs.hotkey.bind('alt', 'tab', 'Next window',hs.window.switcher.nextWindow)

-- you can also bind to `repeatFn` for faster traversing
-- hs.hotkey.bind('alt-shift', 'tab', 'Prev window', hs.window.switcher.previousWindow,nil,hs.window.switcher.previousWindow)
hs.hotkey.bind('alt-shift', 'tab', 'Prev window', hs.window.switcher.previousWindow
