local yabaiOutput, _, _, _ = hs.execute("which yabai", true)
local YABAI = string.gsub(yabaiOutput, "%s+", "")

require("mod-keys")
local utils = require("utils")

local HYPER = Mod.hyper
local SHYPER = Mod.sHyper

-- local DISPLAYS = {"yabai", "--message", "query", "--displays"}
-- local SPACES = {"yabai", "--message", "query", "--spaces"}
-- local WINDOWS = {"yabai", "--message", "query", "--windows"}

-- local SELECTED_DISPLAY = utils.copy_array(DISPLAYS).insert("--display")
-- local SELECTED_SPACE = utils.copy_array(SPACES).insert("--space")
-- local SELECTED_WINDOW = utils.copy_array(WINDOWS).insert("--window")

local commands = {
	service = {
		restart = "--restart-service",
	},
	space = {
		create = "--message space --create",
		destroy = "--message space --destroy",
	},
	window = {
		focus = {
			west = "--message window --focus west",
			south = "--message window --focus south",
			north = "--message window --focus north",
			east = "--message window --focus east",
		},
		move = {
			west = "--message window --move west",
			south = "--message window --move south",
			north = "--message window --move north",
			east = "--message window --move east",
		},
		resize = {
			wider_left = "--message window --resize top:0:-10",
		},
	},
}

local bindings = {
	-- service
	-- TODO: make this its own function, show alert stating that yabai service has been restarted.
	{ mod = SHYPER, key = "r", command = commands.service.restart },

	-- space
	{ mod = HYPER, key = "s", command = commands.space.create },
	{ mod = SHYPER, key = "s", command = commands.space.destroy },

	-- window
	-- focus
	{ mod = HYPER, key = "h", command = commands.window.focus.west },
	{ mod = HYPER, key = "j", command = commands.window.focus.south },
	{ mod = HYPER, key = "k", command = commands.window.focus.north },
	{ mod = HYPER, key = "l", command = commands.window.focus.east },
	-- move
	-- { mod = SHYPER, key = 'h', command = commands.window.move.west },
	-- { mod = SHYPER, key = 'j', command = commands.window.move.south },
	-- { mod = SHYPER, key = 'k', command = commands.window.move.north },
	-- { mod = SHYPER, key = 'l', command = commands.window.move.east },
	-- resize
	{ mod = SHYPER, key = "h", command = commands.window.resize.wider_left },
}

local function bind_keys(kbs)
	for _, binding in ipairs(kbs) do
		local mod = binding.mod
		local key = binding.key
		local command = binding.command
		hs.hotkey.bind(mod, key, function()
			local yabai_command = string.format("%s %s", YABAI, command)
			-- print(string.format("yabai: %s", yabai_command))
			os.execute(yabai_command)
		end)
	end
end
bind_keys(bindings)
