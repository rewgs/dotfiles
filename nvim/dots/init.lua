local hostname = vim.fn.hostname()

-- TODO: Check if directory exists; if not, handle somehow.
local core = hostname .. "." .. "core"
local lazy = hostname .. "." .. "lazy"

require(core)
require(lazy)
