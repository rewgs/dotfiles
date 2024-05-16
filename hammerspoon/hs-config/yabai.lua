require('mod-keys')

local HYPER = mod.hyper
local SHYPER = mod.sHyper


local displays = {"yabai", "--message", "query", "--displays"}
local spaces = {"yabai", "--message", "query", "--spaces"}
local windows = {"yabai", "--message", "query", "--windows"}

local display = {"yabai", "--message", "query", "--displays", "--display"})
local space = {"yabai", "--message", "query", "--spaces", "--space"})
local window = {"yabai", "--message", "query", "--windows", "--window"})


---@type KeyBinding
local prev = {HYPER, "p"}, hs.execute({ "yabai", "--message", 
                                        "window", "--focus", "prev"})
---@type KeyBinding
local next = {HYPER, "n"}, hs.execute({ "yabai", "--message", 
                                        "window", "--focus", "next"})

-- TODO: hs.execute() returns `output, status, type, rc`
-- I really don't want to return all four of those for each yabai message, 
-- so it's probably best if the hs.execute() calls are wrapped in a function 
-- that deals with `output, status, type, rc` and returns something else.
-----
-- hs.execute(command[, with_user_env]) -> output, status, type, rc
-- https://www.hammerspoon.org/docs/hs.html#execute
-----
-- It should probably return exactly the struct that hs.hotkey.bind() expects:
-- hs.hotkey.bind(mods, key, [message,] pressedfn, releasedfn, repeatfn) -> hs.hotkey object
-- https://www.hammerspoon.org/docs/hs.hotkey.html#bind
-----
-- IE:
-- hs.execute() --> wrapper() --> hs.hotkey.bind()


-- This is the interface that hs.hostkey.bind() expects
function KeyBinding:new (o)
    local o = o or {} -- creates a blank object if user does not provide one
    setmetatable(o, self)
    self.__index = self
    return o
end

function execute_wrapper({cmd})
    local output, status, type, rc = hs.execute(cmd)

    -- TODO: deal with output, status, type, and rc
    -- return results of hs.execute() into interface that hs.hotkey.bind() wants
    -- local key_binding = KeyBinding:new()
end























-------------------------------------------------------------------------------
-- OLD
-------------------------------------------------------------------------------


-- local key_bindings = {
--     hyper = {
--         focus = {
--             _command = {"--focus"}
--             prev = key_binding({HYPER, "h", deepcopy(_command).insert("prev"), false}),
--             next = key_binding({HYPER, "l", deepcopy(_command).insert("next"), false}),
--         },
--         move = {
--             _command = {"--move"}
--             prev = key_binding({HYPER, "h", deepcopy(_command).insert("prev"), false}),
--             next = key_binding({HYPER, "l", deepcopy(_command).insert("next"), false}),
--         }
--     },
--     shyper = {
--         ---@type modkey: string
--         _modkey = SHYPER
--         focus = {
--         }
--     }
-- }


---@type args:
---@type modkey: str
---@type key: str
---@type with_user_env: boolean
local function key_binding({args})
    -- TODO: finish me
    -- Takes in a table (blah blah blah)

    ---@type int
    local num_args = #args

    local modkey = args[0] ---@type string
    local key = args[1] ---@type string
    -- local command = 

    ---@type boolean
    local with_user_env = args[num_args]

    ---@type hs.hotkey object
    return output, status, type, rc = hs.hotkey.bind(modkey, key, function()
        return output, status, type, rc = execute_yabai(command, with_user_env)
    end
end


local function deepcopy(o, seen)
    seen = seen or {}
    if o == nil then return nil end
    if seen[o] then return seen[o] end
    
    local no
    if type(o) == 'table' then
        no = {}
        seen[o] = no
    
        for k, v in next, o, nil do
            no[deepcopy(k, seen)] = deepcopy(v, seen)
        end
        setmetatable(no, deepcopy(getmetatable(o), seen))
    else -- number, string, boolean, etc
        no = o
    end
    return no
end


---output: @type string
---status: @type boolean
---type: @type string
---rc: @type integer
local function execute_yabai({args}) --> output, status, type, rc
    -- NOTE: only takes non-nested table
    ---@type table
    function format_command(args) ---> table
        -- Takes in a table of commands. Returns the same table, except with all elements shifted 
        -- down 2 spaces so that it can be prepended by `yabai --message`.

        local new_command = {}
        new_command[1] = "yabai"
        new_command[2] = "--message"
        for arg in ipairs(args) do
            table.insert(new_command, arg)
        end
        return new_command
    end

    ---@type int
    local num_args = #args

    ---@type table
    local yabai_message_args = { unpack(args, 1, num_args) }

    ---@type boolean
    local with_user_env = args[num_args]

    ---output: @type string
    ---status: @type boolean
    ---type: @type string
    ---rc: @type integer
    local output, status, type, rc = hs.execute{(format_command(yabai_message_args), 
                                                 with_user_env})
end

---@type table
function populate_bindings(bindings)
    for _, map in ipairs(hyper_bindings) do
        local modkey = map[1] ---@type string
        local key = map[2] ---@type string
        local command = map[3] ---@type table
        local with_user_env = map[4] ---@type boolean

        local output, status, type, rc = hs.hotkey.bind(modkey, key, function()
            return output, status, type, rc = execute_yabai(command, with_user_env)
        end
        )
    end
end



local function main()
    populate_bindings
end
