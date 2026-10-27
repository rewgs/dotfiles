local module = {}

local appearance = require("sns-001.appearance")
local font = require("sns-001.font")
local keys = require("sns-001.keys.standard")

function module.apply_to_config(config)
	config.prefer_egl = true
	config.default_prog = { "pwsh.exe" }

	appearance.apply_to_config(config)
	font.apply_to_config(config)
	keys.apply_to_config(config)
end

return module
