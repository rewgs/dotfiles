hl.on("hyprland.start", function()
	-- NOTE: This is crashing since the move to Lua.
	-- hl.exec_cmd("hypridle")

	hl.exec_cmd("waybar")
	-- hl.exec_cmd("kanshi")
	hl.exec_cmd("hyprpm reload -n") -- loads plugins at startup; -n sends a notification if anything goes wrong
	-- hl.exec_cmd("easyeffects --gapplication-service")

	-- clipboard managers
	-- hl.exec_cmd("copyq --start-server")
	-- hl.exec_cmd("clapboard --record")

	-- notification manager
	hl.exec_cmd("dunst")

	-- unbinds
	hl.exec_cmd("hyprctl unbind SUPER, p")
end)
