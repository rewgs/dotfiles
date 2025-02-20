local conman = require("conman")

local name = "neovim"
local alias = { "nvim" }
return {
	name = name,
	alias = alias,
	dst = {
		darwin = os.getenv("XDG_CONFIG_HOME") .. "/" .. alias[1],
		linux = os.getenv("XDG_CONFIG_HOME") .. "/" .. alias[1],
		windows = os.getenv("HOME") .. "/AppData/Local/" .. alias[1],
	},

	install = function()
		-- TODO:
		-- 1. Check if dst exists
		--  - If so, delete it.
		-- 2. Symlink src to dst -- NOTE: Need to be able to get src from Go!
		--
	end,

	setup = function()
		-- TODO:
	end,
}
