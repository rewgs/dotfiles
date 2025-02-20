local app = hs.application.get("iTerm2")

local bindings = {
-- Window/Select Split Pane/Select Pane Left
    {   mod = 'Cmd', key = 'h', action = function()
            local menu_item = app:findMenuItem("Select Pane Left"),
            app:selectMenuItem(menu_item),
        end
    },
}
