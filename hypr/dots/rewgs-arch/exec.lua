---@return nil | string
local function get_random_wallpaper(path)
	local files = {}

	local p = io.popen('find "' .. path .. '" -maxdepth 1 -type f')
	if not p then
		return nil
	end

	for file in p:lines() do
		table.insert(files, file)
	end
	p:close()

	if #files == 0 then
		return nil
	end

	math.randomseed(os.time())
	return files[math.random(#files)]
end

hl.on("hyprland.start", function()
	-- NOTE: This is crashing since the move to Lua.
	-- hl.exec_cmd("hypridle")

	hl.exec_cmd("wayle panel start")
	-- hl.exec_cmd("kanshi")
	-- hl.exec_cmd("hyprpm reload -n") -- loads plugins at startup; -n sends a notification if anything goes wrong
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
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme macOS")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")

	-- cursor: apply to the compositor itself (gsettings alone doesn't affect Hyprland's cursor)
	-- prefers the hyprcursor theme (macOS-hypr); XWayland falls back to XCURSOR_THEME (macOS)
	hl.exec_cmd("hyprctl setcursor macOS-hypr 24")

	-- unbinds
	hl.exec_cmd("hyprctl unbind SUPER, p")

	-- =========================================================================
	-- wallpapers
	-- =========================================================================
	--
	-- Choose one.
	-- If using solid color, set in settings.lua instead.
	--
	hl.exec_cmd("swaybg --image ~/Pictures/wallpapers/dark_4k_denoised.png --mode fill")
	-- hl.exec_cmd("swaybg --image ~/Pictures/wallpapers/rings.jpg --mode fill")

	-- FIXME:
	--
	-- random wallpaper using my script
	-- local home = os.getenv("HOME")
	-- local wallpapers_dir = home .. "/Pictures/wallpapers"
	-- local wallpaper = get_random_wallpaper(wallpapers_dir)
	-- if wallpaper ~= nil then
	-- 	hl.exec_cmd("swaybg --image " .. wallpaper .. " --mode fill")
	-- end
end)
