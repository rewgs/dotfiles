--
-- This file specifies global shortcuts for opening or focusing apps.
--

require("modules.mod-keys")
local HYPER = Mod.hyper

local BROWSER = "/Applications/Zen Browser.app/Contents/MacOS/zen"

local TERMINAL = "/Applications/WezTerm.app/Contents/MacOS/wezterm"

local MAIL = "/Applications/Mimestream.app/Contents/MacOS/Mimestream"

local apps = {
	{ mod = HYPER, key = "return", app = TERMINAL },
	{ mod = HYPER, key = "e", app = "Finder" },
	{ mod = HYPER, key = "i", app = BROWSER },
	{ mod = HYPER, key = "o", app = "Obsidian" },
	{ mod = HYPER, key = "m", app = MAIL },
}

local function bind_keys(kbs)
	for _, b in ipairs(kbs) do
		hs.hotkey.bind(b.mod, b.key, function()
			hs.application.launchOrFocus(b.app)
		end)
	end
end

bind_keys(apps)
