hl.on("hyprland.start", function()
	hl.exec_cmd("hypridle")
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

	-- =========================================================================
	-- wallpapers
	-- =========================================================================
	--
	-- Choose one.
	-- If using solid color, set in settings.lua instead.
	--
	hl.exec_cmd("swaybg --image ~/wallpapers/dark\\ 4k.jpg --mode fill")

	-- random wallpaper using my script
	-- hl.exec_cmd("swaybg --image \"$(python3 ~/dotfiles/hypr/dots/scripts/random-wallpaper.py)\" --mode fill")

	-- =========================================================================
	-- startup apps/workspaces
	-- =========================================================================

	-- FIXME: API change broke the stuff below.

	-- -------------------------------------------------------------------------
	-- 1 - main
	-- -------------------------------------------------------------------------

	-- hl.exec_cmd("[workspace 1 silent] ghostty")

	-- -------------------------------------------------------------------------
	-- 10 - Obsidian
	-- -------------------------------------------------------------------------
	-- hl.exec_cmd("[workspace 10 silent] obsidian")
end)
