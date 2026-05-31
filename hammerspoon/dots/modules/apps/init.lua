--
-- This file specifies global shortcuts for opening or focusing apps.
--

local mod = require("mod").mod
local App = require("app").App

-- local hostname = socket.dns.gethostname()
local username = os.getenv("USER") or os.getenv("USERNAME") or os.getenv("LOGNAME")

local adminApp = "/Applications/"
local userApp = "/Users/"

local apps = {
	iterm2 = App:New("iTerm2"),
	mimestream = App:New("Mimestream"),
	zen = App:New("Zen"),
}

local terminal = apps.iterm2
local mail = apps.mimestream
local browser = apps.zen

-- TODO: Change to {mod = app.mod, key = app.key, name = app.name}
local apps = {
	{ mod = mod.Hyper, key = "return", app = terminal },
	{ mod = mod.Hyper, key = "e", app = "Finder" },
	{ mod = mod.Hyper, key = "i", app = browser },
	{ mod = mod.Hyper, key = "m", app = mail },
}

-- FIXME:
--
-- local function bind_keys(apps)
-- 	for _, app in ipairs(apps) do
-- 		hs.hotkey.bind(app.mod, app.key, function()
-- 			hs.application.launchOrFocus(app.path()
-- 		end)
-- 	end
-- end

bind_keys(apps)
