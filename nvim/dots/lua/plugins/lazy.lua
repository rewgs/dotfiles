-- Loads lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local machine_dir = vim.fn.stdpath("config") .. "/lua/plugins/machine"
local has_machine = vim.fn.isdirectory(machine_dir) == 1

require("lazy").setup({
	{ import = "plugins.common" },
	has_machine and { import = "plugins.machine" } or nil,
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
