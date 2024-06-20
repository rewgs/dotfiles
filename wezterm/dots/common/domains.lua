local wezterm = require('wezterm')
local module = {}

local ssh_domains = {
    {
        connect_automatically = false,
        multiplexing = 'WezTerm',
        name = 'rewgs-nas-debian-vm',
        remote_address = 'rewgs-nas-debian-vm.tailed4ac.ts.net',
        remote_wezterm_path = "/usr/bin/wezterm",
        -- timeout = 60,
        username = 'rewgs',
    },
}

function module.apply_to_config(config)
    config.ssh_domains = ssh_domains
end
return module
