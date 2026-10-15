local focus_or_exec = require("common.binds.helpers").focus_or_exec

-- hl.bind(mainMod .. " + e", hl.dsp.exec_cmd(fileExplorer))
hl.bind(mainMod .. " + i", focus_or_exec(browser, "zen")) -- NOTE: update class if `browser` changes
hl.bind(mainMod .. " + o", focus_or_exec("obsidian", "md.obsidian.Obsidian"))
hl.bind(mainMod .. " + d", focus_or_exec("discord", "discord"))
