local wezterm = require('wezterm')
local module = {}

local ssh_domains = {
    {
        connect_automatically = false,
        -- multiplexing = 'WezTerm',
        name = 'rewgs-nas-arch-vm',
        -- remote_address = 'rewgs@rewgs-nas-arch-vm.tailed4ac.ts.net:8080',
        remote_address = 'rewgs-nas-arch-vm:8080',
        remote_wezterm_path = "/usr/bin/wezterm",
        username = 'rewgs',
    },
}

function module.apply_to_config(config)
    config.ssh_domains = ssh_domains
end
return module
