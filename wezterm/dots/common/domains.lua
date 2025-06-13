-- local wezterm = require('wezterm')
local module = {}

local ssh_domains = {
	{
		name = "arch-vm",
		connect_automatically = false,
		multiplexing = "WezTerm",
		remote_address = "rewgs-nas-arch-vm",
		remote_wezterm_path = "/usr/bin/wezterm",
		username = "rewgs",
		default_prog = { "zsh" },
	},
}

function module.apply_to_config(config)
	config.ssh_domains = ssh_domains
end
return module
