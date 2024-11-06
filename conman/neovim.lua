local conman = require("conman")
local dot = {}

dot.name = "neovim"
dot.altName = "nvim"
dot.confs = {
    darwin = {
        src = conman.dotfiles .. dot.altName,
        dst = os.getenv("XDG_CONFIG_HOME") .. "/" .. dot.altName,
    },
    linux = {
        src = conman.dotfiles .. dot.altName,
        dst = os.getenv("XDG_CONFIG_HOME") .. "/" .. dot.altName,
    },
    windows = {
        src = conman.dotfiles .. dot.altName,
        dst = os.getenv("HOME") .. "/AppData/Local/" .. dot.altName,
    },
}

-- TODO:
dot.install = function()
end

-- TODO:
-- dot.setup = function()
-- end

return dot
