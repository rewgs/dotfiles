require("modules.mod-keys")

-------------------------------------------------------------------------------
-- NOTE: In progress: Space "class"/datatype.
-- Reference: http://lua-users.org/wiki/ObjectOrientationTutorial

local Space = {}
Space.__index = Space

function Space.new(init)
	local self = setmetatable({}, Space)
	self.value = init
	return self
end

function Space.setValue(self, value)
	self.value = value
end

function Space.getValue(self)
	return self.value
end

-------------------------------------------------------------------------------

-- Returns a simple table of spaceIDs
local function getSpaces() --> table
	local res, err = hs.spaces.allSpaces()
	if res == nil then
		hs.alert.show(err, 10)
	else
		local spaces_table = {}
		for _, value in pairs(res) do
			table.insert(spaces_table, value)
		end

		local spaces = {}
		for i, space in ipairs(spaces_table[1]) do
			local new_space = {}
			new_space.index = i
			new_space.id = space
			table.insert(spaces, new_space)
		end

		-- debug
		-- for _, space in ipairs(spaces)  do
		--     hs.alert.show("Space " .. space.index .. ": " .. space.id)
		-- end
		return spaces
	end
end

local function getFocusedSpace()
	local spaceId = hs.spaces.focusedSpace()
	hs.alert.show(spaceId, 10)
end

local function getSpaceIndex(id, allSpaces) --> int
	for _, space in ipairs(allSpaces) do
		if space.id == id then
			return space.index
		end
	end
	return nil
end

local function getNextSpace(index, allSpaces) --> Space
	for _, space in ipairs(allSpaces) do
		if space.index == index + 1 then
			return space
		end
	end
	return nil
end

local function getPrevSpace(index, allSpaces)
	for _, space in ipairs(allSpaces) do
		if space.index == index - 1 then
			return space
		end
	end
	return nil
end

-- debug
-- for screen_uuid, space_table in pairs(SPACES) do
--     for space_id in ipairs(space_table) do
--         message = "Screen UUID: " .. screen_uuid .. "; space ID: " .. space_id
--         hs.alert.show(message, 5)
--     end
-- end

-- NOTE: This should work, but it doesn't. Appears to be a common problem.
-- hs.hotkey.bind(mod.sHyper, "h", function() --> bool
local function goToPrevSpace()
	local allSpaces = getSpaces()
	local focusedSpaceId = hs.spaces.focusedSpace()
	local focusedSpaceIndex = getSpaceIndex(focusedSpaceId, allSpaces)
	if focusedSpaceIndex ~= nil then
		-- hs.alert.show(focusedSpaceIndex, 3)
		res, err = hs.spaces.gotoSpace(getPrevSpace(focusedSpaceIndex, allSpaces).id)
		if not res then
			hs.alert.show(err, 10)
		end
	end
end

-- NOTE: This should work, but it doesn't. Appears to be a common problem.
-- hs.hotkey.bind(mod.sHyper, "l", function()
local function goToNextSpace()
	local allSpaces = getSpaces()
	local focusedSpaceId = hs.spaces.focusedSpace()
	local focusedSpaceIndex = getSpaceIndex(focusedSpaceId, allSpaces)
	if focusedSpaceIndex ~= nil then
		-- hs.alert.show(focusedSpaceIndex, 3)
		res, err = hs.spaces.gotoSpace(getNextSpace(focusedSpaceIndex, allSpaces).id)
		if not res then
			hs.alert.show(err, 10)
		end
	end
end

-------------------------------------------------------------------------------
-- Key bindings
-------------------------------------------------------------------------------

-- NOTE: Temporarily using sHyper instead of hyper, as the latter isn't working. Maybe there's a conflict?
-- hs.hotkey.bind(Mod.oHyper, "left", goToPrevSpace)
-- hs.hotkey.bind(Mod.oHyper, "right", goToNextSpace)
-- hs.hotkey.bind(Mod.hyper, "up", function()
-- 	hs.spaces.toggleMissionControl()
-- end)
-- hs.hotkey.bind(Mod.hyper, "down", function()
-- 	hs.spaces.closeMissionControl()
-- end)
-- hs.hotkey.bind(Mod.hyper, "d", function()
-- 	hs.spaces.toggleShowDesktop()
-- end)

-- hs.hotkey.bind(mod.hyper, "escape", getSpaces)
