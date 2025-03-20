-- local hostname = vim.fn.hostname()
-- local core = hostname .. "." .. "core"
-- local lazy = hostname .. "." .. "lazy"
-- require(core)
-- require(lazy)

-- Force use of zig compiler on Windows
-- local uname = vim.loop.os_uname()
-- if uname.sysname:find 'Windows' and uname.release:find 'Microsoft' then
--     require ('nvim-treesitter.install').compilers = { 'zig' }
-- end


require("core")
require("plugins.lazy")

-- Uses clang and zig on Windows
if vim.loop.os_uname().version:match("Windows") then
    require('nvim-treesitter.install').compilers = { 'clang', 'zig' }
end