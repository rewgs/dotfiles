-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Browser workspace assignments
hl.window_rule({ match = { title = ".*Mozilla Firefox.*" }, workspace = "2" })
hl.window_rule({ match = { title = ".*Zen Browser.*" }, workspace = "2" })
hl.window_rule({ match = { title = ".*Google Chrome.*" }, workspace = "3" })
hl.window_rule({ match = { title = ".*Spotify.*" }, workspace = "4" }) -- FIXME: verify match field
hl.window_rule({ match = { title = ".*Discord.*" }, workspace = "5" })
hl.window_rule({ match = { title = ".*Element.*" }, workspace = "5" })
hl.window_rule({ match = { title = ".*Signal.*" }, workspace = "5" })
hl.window_rule({ match = { title = ".*Slack.*" }, workspace = "5" })
hl.window_rule({ match = { title = ".*Obsidian.*" }, workspace = "10" })
hl.window_rule({ match = { title = "Steam" }, workspace = "11" })

-- JetBrains fixes
hl.window_rule({
	match = { class = "jetbrains-toolbox", float = true },
	no_initial_focus = true,
})
hl.window_rule({
	match = { class = "(jetbrains-)(.*)", title = "^$", initial_title = "^$", float = true },
	no_initial_focus = true,
})
hl.window_rule({
	match = { class = "(jetbrains-)(.*)", title = "^$", initial_title = "^$", float = true },
	center = true,
})
hl.window_rule({
	match = { class = "(jetbrains-)(.*)", initial_title = ".+", float = true },
	center = true,
})

-- Reaper fixes
-- https://github.com/hyprwm/Hyprland/issues/2278
hl.window_rule({ match = { class = "REAPER", float = true }, move = { "cursor_x", "cursor_y" } })
hl.window_rule({ match = { class = "REAPER", title = "^(menu)$" }, no_initial_focus = true })
hl.window_rule({ match = { class = "REAPER", title = "^$" }, no_initial_focus = true })
-- hl.window_rule({ match = { class = "REAPER", title = "^$" },               no_anim = true })  -- FIXME: verify effect name

-- Floating terminal
hl.window_rule({ match = { class = "^(floaterm)$" }, float = true })
hl.window_rule({ match = { class = "^(floaterm)$" }, size = { "750", "500" } })
hl.window_rule({ match = { class = "^(floaterm)$" }, center = true })
-- hl.window_rule({ match = { class = "^(floaterm)$" }, opacity = ... })  -- FIXME: verify active/inactive opacity syntax
