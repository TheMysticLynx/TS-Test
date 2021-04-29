-- Compiled with roblox-ts v1.1.1
-- eslint-disable prettier/prettier
local Item
do
	Item = setmetatable({}, {
		__tostring = function()
			return "Item"
		end,
	})
	Item.__index = Item
	function Item.new(...)
		local self = setmetatable({}, Item)
		self:constructor(...)
		return self
	end
	function Item:constructor(name, cost, model)
		self.Name = name
		self.Cost = cost
		if model then
			self.Model = model
		else
			local _0 = game:GetService("ReplicatedStorage"):FindFirstChild("Models")
			if _0 ~= nil then
				_0 = _0:FindFirstChild(name)
			end
			local temp = _0
			if temp then
				local _1 = temp:IsA("Model")
				local _2 = "No model found for: " .. name
				assert(_1, _2)
				self.Model = temp
			else
				error("No model found for: " .. name)
			end
		end
	end
end
return {
	Item = Item,
}
