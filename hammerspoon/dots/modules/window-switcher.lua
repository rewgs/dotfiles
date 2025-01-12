require("modules.mod-keys")

local hyper = Mod.hyper
local shyper = Mod.sHyper

local uiPrefs = {
	textColor = { 1, 1, 1 },
	fontName = "Lucida Grande",
	textSize = 16,
	backgroundColor = { 0.3, 0.3, 0.3, 1 },
	highlightColor = { 0.8, 0.5, 0, 0.8 },
	showTitles = false,
	titleBackgroundColor = { 0, 0, 0 },
	showThumbnails = true,
	thumbnailSize = 128,
	showSelectedThumbnail = true,
	selectedThumbnailSize = 384,
	showSelectedTitle = true,
	showExtraKeys = true,
}

-- default windowfilter: only visible windows, all Spaces
switcher = hs.window.switcher.new()

-- FIXME: Passing this completely hides the switcher?!
-- MAIN_SWITCHER.ui = uiPrefs

-- hs.hotkey.bind("alt", "tab", hs.window.switcher.nextWindow, nil, hs.window.switcher.nextWindow)
-- hs.hotkey.bind("alt-shift", "tab", hs.window.switcher.previousWindow, nil, hs.window.switcher.previousWindow)
hs.hotkey.bind("alt", "tab", hs.window.switcher.nextWindow, nil, hs.window.switcher.nextWindow)
hs.hotkey.bind("alt-shift", "tab", hs.window.switcher.previousWindow, nil, hs.window.switcher.previousWindow)
