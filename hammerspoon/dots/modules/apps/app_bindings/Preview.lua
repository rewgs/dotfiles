-- TODO: Get this to work!
-- This file specifies custom key bindings for Preview.

local app = hs.application.get("Preview")

local bindings = {
    {   mod = 'Cmd', key = 'h', action = function()
            local menu_item = app:findMenuItem("Highlight Text")
            app:selectMenuItem(menu_item)
        end
    },
}

-- local function bind_keys(kbs)
--     if app:isFrontmost() then
--         for _, b in ipairs(kbs) do
--             hs.hotkey.bind(b.mod, b.key, b.action)
--         end
--     end
-- end
-- bind_keys(bindings)
