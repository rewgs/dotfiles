return {
    -- "akinsho/flutter-tools.nvim",
    "nvim-flutter/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("flutter-tools").setup {
            -- NOTE: This *must* be true if using fvm, or else the flutter
            -- binary won't be found (since it's executed via `fvm flutter`,
            -- not `flutter`).
            fvm = true,
        }
    end,
}
