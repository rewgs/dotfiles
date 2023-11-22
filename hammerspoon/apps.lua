require('keys')

-- @type table
-- function open(application) --> none
--     if #application > 2 or #application < 2 then
--         return
--     end

--     local app = application['name'] or nil
--     local key = application['key'] or nil

--     if app == nil or key == nil then
--         return
--     end

--     local app_exists = hs.application.get(app)
--     if app_exists then
--         app_exists:activate(false)
--         hs.eventtap.keyStroke(key)
--     else
--         hs.application.launchOrFocus(app)
--     end
-- end

for _, app in ipairs(keys.apps) do
    hs.alert.show(app.name)
    -- hs.hotkey.bind(keys.super, app.key, function() hs.application.launchOrFocus(app.name) end)
end
