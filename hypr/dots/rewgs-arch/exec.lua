hl.on("hyprland.start", function()
	-- NOTE: This is crashing since the move to Lua.
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

	-- theming: set gsettings on each startup so these are declarative/source-controlled
	-- GTK4/libadwaita ignores GTK_THEME and reads color-scheme from gsettings instead
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme Adwaita")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme Adwaita")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")

	-- cursor: apply to the compositor itself (gsettings alone doesn't affect Hyprland's cursor)
	hl.exec_cmd("hyprctl setcursor Adwaita 24")

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
end)
