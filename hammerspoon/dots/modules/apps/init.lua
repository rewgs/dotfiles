--
-- This file specifies global shortcuts for opening or focusing apps.
--

require("modules.mod")

local browser = "/Applications/Zen Browser.app/Contents/MacOS/zen"
local mail = "/Applications/Mimestream.app/Contents/MacOS/Mimestream"
local terminal = "/Applications/iTerm.app/Contents/MacOS/iTerm2"
-- local terminal = "/Applications/WezTerm.app/Contents/MacOS/wezterm"

local apps = {
	{ mod = Mod.Hyper, key = "return", app = terminal },
	{ mod = Mod.Hyper, key = "e", app = "Finder" },
	-- { mod = Mod.Hyper, key = "i", app = browser },
	{ mod = Mod.Hyper, key = "m", app = MAIL },
}

local function bind_keys(kbs)
	for _, b in ipairs(kbs) do
		hs.hotkey.bind(b.mod, b.key, function()
			hs.application.launchOrFocus(b.app)
		end)
	end
end

bind_keys(apps)
