local lfs = require("lfs")

local adminAppPath = "/Applications/"
local userAppPath = "/Users/"

local function exists(path)
	-- returns attributes table if it exists, nil otherwise
	return lfs.attributes(path) ~= nil
end

local function isDir(path)
	return lfs.attributes(path, "mode") == "directory"
end

---App provides a wrapper for the reaper ReaProject type.
---@class App
---@field name string -- The name of the application.
---@field path string | nil -- Override inf
local App = {}

---Project.New returns a newly initialized Project object.
---@param name string
---@param path string | nil
---@return App | nil, nil | string
function App:New(name, path)
	local new = {}

	setmetatable(new, self)
	self.__index = self

	---@type string
	self.name = name

	---@type string | nil
	self.path = path

	return new, nil
end

---This is essentially a @property in Python with the error handling of Go.
---@return string
function App:Path()
	---@type boolean
	local success

	---@type string | nil
	local path

	---@type string | nil
	local err

	success, path, err = pcall(function()
		if path ~= nil then
			self.path = path
		else
			self.path = self.name .. ".app/Contents/MacOS/" .. self.name .. "\n"
			if not exists(self.path) then
				err = "error getting path of app " .. self.name .. ": could not infer path from name" .. "\n"
				err = err .. "try overriding the path arg" .. "\n"
				return nil, err
			end
		end
		if self.path == nil then
			return nil, "error creating App " .. self.name .. ": unknown error" .. "\n"
		end
	end)

	if not success then
		error(err)
	end

	if path ~= nil then
		return path
	end

	error("error creating App " .. self.name .. ": impossible state" .. "\n")
end

---@return string | nil
function App:AdminPath()
	return adminAppPath .. self:Path()
end

---@return string | nil
function App:UserPath()
	return userAppPath .. self:Path()
end

return {
	App = App,
}
