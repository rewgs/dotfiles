local conman = require("conman")
local dot = {}

dot.name = "neovim"
dot.altName = "nvim"
dot.desc = ""
dot.confs = {
    {
        os = "darwin",
        src = conman.dotfiles .. dot.altName,
        dst = os.getenv("XDG_CONFIG_HOME") .. "/" .. dot.altName,
    },
    {
        os = "linux",
        src = conman.dotfiles .. dot.altName,
        dst = os.getenv("XDG_CONFIG_HOME") .. "/" .. dot.altName,
    },
    {
        os = "windows",
        src = conman.dotfiles .. dot.altName,
        dst = os.getenv("HOME") .. "/AppData/Local/" .. dot.altName,
    },
}

dot.install = function()
end

dot.setup = function()
end

return dot
