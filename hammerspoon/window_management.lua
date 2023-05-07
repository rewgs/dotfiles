function show_grid(mod1, mod2, key)
    hs.hotkey.bind({mod1, mod2}, key, function()
    hs.grid.show()
    end)
end


-- abandonining this, making separate functions for all/main/primary instead
function set_grid(which_screen, grid_width, grid_height)
    local f = nil
    local g = nil
    local s = nil

    if which_screen == 'all' then
        s = hs.screen.allScreens()

    -- the focused display
    elseif which_screen == 'main' then
        s = hs.screen.mainScreen()
        g = hs.grid.getGrid(s)
        f = hs.grid.getGridFrame(s)

        local grid = hs.grid.setGrid(g, s, f)
        

    -- the primary display, as set in System Settings/Display
    elseif which_screen == 'primary' then
        s = hs.screen.primaryScreen()

    else
        hs.notify.new({
            title = 'Hammerspoon',
            informativeText = 'Incorrect screen selected.'}):send()
    end
end


function set_main_screen_grid_dimensions(width, height)
    hs.grid.MARGINX = 0
    hs.grid.MARGINY = 0
    hs.grid.GRIDWIDTH = width
    hs.grid.GRIDHEIGHT = height
    -- local s = hs.screen.mainScreen()
    -- local g = hs.grid.getGrid(s)
    -- local f = hs.grid.getGridFrame(s)

    -- local grid = hs.grid.setGrid(g, s, f)
end


function set_focused_screen_grid(mod1, mod2, mod3, key, width, height)
    hs.hotkey.bind({mod1, mod2, mod3}, key, function()
        set_main_screen_grid_dimensions(width, height)
        hs.grid.show()
    end)
end



function snap_focused_window(direction, size, mod1, mod2, key)
    local win = hs.window.focusedWindow()

    local f = win:frame()
    local s = win:screen()

    if direction == 'maximize' then
        if size == nil then
            hs.hotkey.bind({mod1, mod2}, key, function()
                hs.grid.maximizeWindow(win)             
            end)
        end
    end

    -- if direction = 'left' then
        -- if size = 'half' then
        --     hs.hotkey.bind({mod1, mod2}, key, function()
        --         f.x
        --     end)
        -- end
    -- elseif
    --     direction = 'bottom' then
    -- elseif
    --     direction = 'top' then
    -- elseif
    --     direction = 'right' then
    -- elseif
    --     direction = 'maximize' then
    --         if size = nil then
    --             hs.hotkey.bind({mod1, mod2}, key, function()
    --                 hs.grid.maximizeWindow(win)             
    --             end)
    --         end
    -- end
end








-- snap window left half
-- hs.hotkey.bind({"cmd", "ctrl"}, "H", function()
--   local win = hs.window.focusedWindow()

--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()

--   f.x = max.x
--   f.y = max.y
--   f.w = max.w / 2
--   f.h = max.h

--   win:setFrame(f)
-- end)

-- snap window right half		NOT WORKING
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
--
--   f.x = max.x
--   f.y = max.y
--   f.w = max.w
--   f.h = max.h
--   win:setFrame(f)
-- end)

-- snap window top half			WORKING
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
--
--   f.x = max.x
--   f.y = max.y
--   f.w = max.w
--   f.h = max.h / 2
--   win:setFrame(f)
-- end)

-- snap window bottom half		NOT WORKING
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
--   local win = hs.window.focusedWindow()
--   local f = win:frame()
--   local screen = win:screen()
--   local max = screen:frame()
--
--   f.x = max.x
--   f.y = max.y
--   f.w = max.w
--   f.h = max.h
--   win:setFrame(f)
-- end)
