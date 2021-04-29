-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local Item = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Item").Item
local Placeable
do
	local super = Item
	Placeable = setmetatable({}, {
		__tostring = function()
			return "Placeable"
		end,
		__index = super,
	})
	Placeable.__index = Placeable
	function Placeable.new(...)
		local self = setmetatable({}, Placeable)
		self:constructor(...)
		return self
	end
	function Placeable:constructor(...)
		super.constructor(self, ...)
	end
end
local Equipable
do
	local super = Item
	Equipable = setmetatable({}, {
		__tostring = function()
			return "Equipable"
		end,
		__index = super,
	})
	Equipable.__index = Equipable
	function Equipable.new(...)
		local self = setmetatable({}, Equipable)
		self:constructor(...)
		return self
	end
	function Equipable:constructor(...)
		super.constructor(self, ...)
	end
end
local Rack
do
	local super = Placeable
	Rack = setmetatable({}, {
		__tostring = function()
			return "Rack"
		end,
		__index = super,
	})
	Rack.__index = Rack
	function Rack.new(...)
		local self = setmetatable({}, Rack)
		self:constructor(...)
		return self
	end
	function Rack:constructor(...)
		super.constructor(self, ...)
	end
end
local Decoration
do
	local super = Placeable
	Decoration = setmetatable({}, {
		__tostring = function()
			return "Decoration"
		end,
		__index = super,
	})
	Decoration.__index = Decoration
	function Decoration.new(...)
		local self = setmetatable({}, Decoration)
		self:constructor(...)
		return self
	end
	function Decoration:constructor(...)
		super.constructor(self, ...)
	end
end
local Utility
do
	local super = Placeable
	Utility = setmetatable({}, {
		__tostring = function()
			return "Utility"
		end,
		__index = super,
	})
	Utility.__index = Utility
	function Utility.new(...)
		local self = setmetatable({}, Utility)
		self:constructor(...)
		return self
	end
	function Utility:constructor(...)
		super.constructor(self, ...)
	end
end
local Fan
do
	local super = Equipable
	Fan = setmetatable({}, {
		__tostring = function()
			return "Fan"
		end,
		__index = super,
	})
	Fan.__index = Fan
	function Fan.new(...)
		local self = setmetatable({}, Fan)
		self:constructor(...)
		return self
	end
	function Fan:constructor(name, cost, coolingPower, model)
		super.constructor(self, name, cost, model)
		self.CoolingPower = coolingPower
	end
end
local Gpu
do
	local super = Equipable
	Gpu = setmetatable({}, {
		__tostring = function()
			return "Gpu"
		end,
		__index = super,
	})
	Gpu.__index = Gpu
	function Gpu.new(...)
		local self = setmetatable({}, Gpu)
		self:constructor(...)
		return self
	end
	function Gpu:constructor(name, cost, powerUsage, roCoinPerSec, model)
		super.constructor(self, name, cost, model)
		self.PowerUsage = powerUsage
		self.RoCoinPerSec = roCoinPerSec
	end
end
local ItemsMap = {}
local function NewItem(item)
	local _0 = ItemsMap
	local _1 = item.Name
	local _2 = item
	-- ▼ Map.set ▼
	_0[_1] = _2
	-- ▲ Map.set ▲
end
NewItem(Decoration.new("Noob", 100000000))
NewItem(Utility.new("Basic Generator", 100))
NewItem(Rack.new("Basic Rack", 100))
NewItem(Fan.new("Basic Fan", 100, 10))
NewItem(Gpu.new("Basic Gpu", 100, 100, 1))
return {
	Placeable = Placeable,
	Equipable = Equipable,
	Rack = Rack,
	Decoration = Decoration,
	Utility = Utility,
	Fan = Fan,
	Gpu = Gpu,
	Items = ItemsMap,
}
