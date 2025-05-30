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

-- If config for current host does not exist, uses MacBook Air's config.
-- local hostSpecific = "plugins" .. "." .. vim.fn.hostname()
-- NOTE: the 0 in this case is returned if the directory does *not* exist, as 0 is a false-y value in Lua.
-- if vim.fn.isdirectory(hostSpecific) == 0 then
-- 	hostSpecific = "plugins" .. "." .. "rewgs-2021-macbook-air"
-- end

require("lazy").setup({
	{ import = "plugins" .. "." .. "common" },
	-- { import = hostSpecific },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
