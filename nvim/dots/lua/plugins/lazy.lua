local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        { import = "plugins" .. "." .. "common" },
        { import = "plugins" .. "." .. "common" .. "." .. "lsp" },
        -- TODO: Handle if this directory doesn't eixst.
        { import = "plugins" .. "." .. vim.fn.hostname() },
    },
    {
        checker = {
            enabled = true,
            notify = false
        },
        change_detection = {
            notify = false
        }
    }
)
