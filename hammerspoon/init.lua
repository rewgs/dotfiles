-- good reference here: https://github.com/NateEag/dotfiles/blob/d8c81c3890af65bf4316718426d88e13398e6eaa/src/.hammerspoon/init.lua


cli_installed = hs.ipc.cliStatus()


---------------------------------------------------------------------------------------------------
-- HYPER KEY
---------------------------------------------------------------------------------------------------

-- Note: this requires that the "CapsLock to Hyper" Karabiner Elements Complex Modification be 
-- setup and running before the Hyper key will work.
local hyper = {'cmd', 'alt', 'ctrl', 'shift'}

-- Load and create a new switcher
local HyperKey = hs.loadSpoon("HyperKey")
hyperKey = HyperKey:new(hyper, {
  overlayTimeoutMs = 1000, -- wait 1000ms instead
})

-- Bind some applications to keys
hyperKey
  :bind('c'):toApplication('/Applications/Google Chrome.app')
  :bind('s'):toApplication('/Applications/Spotify.app')
  :bind('t'):toApplication('/Applications/iTerm.app')

-- Bind some functions to keys
local reloadHammerspoon = function()
  hs.application.launchOrFocus("Hammerspoon")
  hs.reload()
end

-- hyperKey
--   :bind('h'):toFunction("Reload Hammerspoon", reloadHammerspoon)
--   :bind('l'):toFunction("Lock screen", hs.caffeinate.startScreensaver)





-- snap window left half		WORKING
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
--
--   f.x = max.x
--   f.y = max.y
--   f.w = max.w / 2
--   f.h = max.h
--   win:setFrame(f)
-- end)

-- snap window right half		NOT WORKING
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
--
--   f.x = max.x
--   f.y = max.y
--   f.w = max.w
--   f.h = max.h
--   win:setFrame(f)
-- end)

-- snap window top half			WORKING
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
--
--   f.x = max.x
--   f.y = max.y
--   f.w = max.w
--   f.h = max.h / 2
--   win:setFrame(f)
-- end)

-- snap window bottom half		NOT WORKING
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
--
--   f.x = max.x
--   f.y = max.y
--   f.w = max.w
--   f.h = max.h
--   win:setFrame(f)
-- end)
