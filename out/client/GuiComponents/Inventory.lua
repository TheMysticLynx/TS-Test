-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local ClientDataService = TS.import(script, script.Parent.Parent, "Modules", "ClientDataService")
local setSelectedPart = TS.import(script, script.Parent.Parent, "Modules", "PlacementManager").setSelectedPart
local Item = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Item").Item
local _0 = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Items")
local Decoration = _0.Decoration
local Fan = _0.Fan
local Gpu = _0.Gpu
local Items = _0.Items
local Placeable = _0.Placeable
local Rack = _0.Rack
local Utility = _0.Utility
local InventoryItem = TS.import(script, script.Parent, "InventoryItem").InventoryItem
local Inventory
do
	Inventory = Roact.Component:extend("Inventory")
	function Inventory:init(props)
		local _1 = {
			show = false,
			BtcSText = 0,
			PowerUsageText = 0,
			SellPriceText = 0,
			ItemName = "N/A",
			SortClass = Item,
		}
		local _2 = "Inventory"
		local _3 = ClientDataService:GetData()
		if _3 ~= nil then
			_3 = _3.Items
		end
		_1[_2] = _3
		self.state = _1
		self.viewPortRef = Roact.createRef()
	end
	function Inventory:setVisibility(v)
		self:setState({
			show = v,
		})
	end
	function Inventory:getItems(myClass)
		local items = {}
		local _1 = Items
		local _2 = function(v)
			local _3 = self.state.Inventory
			if _3 ~= nil then
				local _4 = v.Name
				_3 = _3[_4]
			end
			local count = _3
			local _4 = false
			if type(v) == "table" then
				local _5 = getmetatable(v)
				while _5 ~= nil do
					if _5 == myClass then
						_4 = true
						break
					else
						local _6 = getmetatable(_5)
						if _6 then
							_5 = _6.__index
						else
							break
						end
					end
				end
			end
			local _5 = _4
			if _5 then
				_5 = count ~= nil and count > 0
			end
			if _5 then
				local _6 = items
				local _7 = {
					i = v,
					c = count,
				}
				-- ▼ Array.push ▼
				_6[#_6 + 1] = _7
				-- ▲ Array.push ▲
			end
		end
		-- ▼ ReadonlyMap.forEach ▼
		for _3, _4 in pairs(_1) do
			_2(_4, _3, _1)
		end
		-- ▲ ReadonlyMap.forEach ▲
		return items
	end
	function Inventory:didMount()
		self.props.SetRef(self)
		ClientDataService.dataChanged:Connect(function(d)
			self:setState({
				Inventory = d.Items,
			})
		end)
	end
	function Inventory:render()
		local ItemFrames = {}
		local _1 = self:getItems(self.state.SortClass)
		local _2 = function(v)
			local newState = {
				BtcSText = 0,
				PowerUsageText = 0,
				SellPriceText = v.i.Cost * .75,
				ItemName = v.i.Name,
			}
			local _3 = false
			if type(v) == "table" then
				local _4 = getmetatable(v)
				while _4 ~= nil do
					if _4 == Gpu then
						_3 = true
						break
					else
						local _5 = getmetatable(_4)
						if _5 then
							_4 = _5.__index
						else
							break
						end
					end
				end
			end
			if _3 then
				newState.BtcSText = v.RoCoinPerSec
				newState.PowerUsageText = v.PowerUsage
			end
			local _4 = ItemFrames
			local _5 = Roact.createFragment({
				[v.i.Name] = Roact.createElement(InventoryItem, {
					count = v.c,
					item = v.i,
					previewRef = self.viewPortRef,
					MouseButtonClick = function()
						self:setState(newState)
						local _6 = v.i
						local _7 = false
						if type(_6) == "table" then
							local _8 = getmetatable(_6)
							while _8 ~= nil do
								if _8 == Placeable then
									_7 = true
									break
								else
									local _9 = getmetatable(_8)
									if _9 then
										_8 = _9.__index
									else
										break
									end
								end
							end
						end
						if _7 then
							setSelectedPart(v.i)
						end
					end,
				}),
			})
			-- ▼ Array.push ▼
			_4[#_4 + 1] = _5
			-- ▲ Array.push ▲
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _3, _4 in ipairs(_1) do
			_2(_4, _3 - 1, _1)
		end
		-- ▲ ReadonlyArray.forEach ▲
		local _3 = {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1, 0, 1, 0),
			Visible = self.state.show,
		}
		local _4 = {}
		local _5 = #_4
		local _6 = {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6656665774",
			Position = UDim2.new(0.246, 0, 0.242, 0),
			Size = UDim2.new(0.507, 0, 0.517, 0),
		}
		local _7 = {
			Preview = Roact.createElement("ImageLabel", {
				BackgroundTransparency = 1,
				Image = "rbxassetid://6656697737",
				Position = UDim2.new(0.04, 0, 0.185, 0),
				Size = UDim2.new(0.178, 0, 0.286, 0),
			}, {
				["1"] = Roact.createElement("ViewportFrame", {
					[Roact.Ref] = self.viewPortRef,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.095, 0, 0.095, 0),
					Size = UDim2.new(0.8, 0, 0.8, 0),
				}),
			}),
			ExitButton = Roact.createElement("TextButton", {
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSans,
				Position = UDim2.new(0.935, 0, 0.037, 0),
				Size = UDim2.new(0.044, 0, 0.072, 0),
				Text = "X",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextStrokeColor3 = Color3.fromRGB(255, 255, 255),
				TextWrapped = true,
				[Roact.Event.MouseButton1Click] = function()
					self:setVisibility(false)
				end,
			}),
			GpuName = Roact.createElement("TextLabel", {
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSans,
				Position = UDim2.new(0.06, 0, 0.545, 0),
				Size = UDim2.new(0.132, 0, 0.043, 0),
				Text = self.state.ItemName,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
			}),
			Roact.createElement("ImageLabel", {
				BackgroundTransparency = 1,
				Image = "rbxassetid://6656675417",
				Position = UDim2.new(0.036, 0, 0.607, 0),
				Size = UDim2.new(0.033, 0, 0.058, 0),
			}),
			["Btc/s"] = Roact.createElement("TextLabel", {
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSans,
				Position = UDim2.new(0.079, 0, 0.607, 0),
				Size = UDim2.new(0.105, 0, 0.058, 0),
				Text = tostring(self.state.BtcSText),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
			}),
			["W/s"] = Roact.createElement("TextLabel", {
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSans,
				Position = UDim2.new(0.079, 0, 0.681, 0),
				Size = UDim2.new(0.105, 0, 0.058, 0),
				Text = tostring(self.state.PowerUsageText),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
			}),
			Roact.createElement("ImageLabel", {
				BackgroundTransparency = 1,
				Image = "rbxassetid://6656680129",
				Position = UDim2.new(0.041, 0, 0.681, 0),
				Size = UDim2.new(0.024, 0, 0.058, 0),
			}),
			Roact.createElement("ImageButton", {
				BackgroundTransparency = 1,
				Image = "rbxassetid://6656685771",
				Position = UDim2.new(0.042, 0, 0.822, 0),
				Size = UDim2.new(0.167, 0, 0.043, 0),
			}),
			Roact.createElement("ImageButton", {
				BackgroundTransparency = 1,
				Image = "rbxassetid://6656686528",
				Position = UDim2.new(0.042, 0, 0.875, 0),
				Size = UDim2.new(0.167, 0, 0.043, 0),
			}),
			Roact.createElement("TextLabel", {
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSans,
				Position = UDim2.new(0.042, 0, 0.764, 0),
				Size = UDim2.new(0.087, 0, 0.058, 0),
				Text = "Sell for",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
			}),
			Price = Roact.createElement("TextLabel", {
				BackgroundTransparency = 1,
				Font = Enum.Font.SourceSans,
				Position = UDim2.new(0.131, 0, 0.764, 0),
				Size = UDim2.new(0.078, 0, 0.058, 0),
				Text = tostring(self.state.SellPriceText),
				TextColor3 = Color3.fromRGB(45, 220, 53),
				TextScaled = true,
				TextSize = 14,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Left,
			}),
		}
		local _8 = #_7
		local _9 = {
			Active = true,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.271, 0, 0.187, 0),
			Size = UDim2.new(0.694, 0, 0.745, 0),
		}
		local _10 = {}
		local _11 = #_10
		for _12, _13 in ipairs(ItemFrames) do
			_10[_11 + _12] = _13
		end
		_11 = #_10
		_10[_11 + 1] = Roact.createElement("UIGridLayout", {
			CellPadding = UDim2.new(0, 10, 0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
		_7[_8 + 1] = Roact.createElement("ScrollingFrame", _9, _10)
		_7[_8 + 2] = Roact.createElement("UIAspectRatioConstraint", {
			AspectRatio = 1.721,
		})
		_4.Frame = Roact.createElement("ImageLabel", _6, _7)
		_4.GpuSort = Roact.createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6656769850",
			Position = UDim2.new(0.196, 0, 0.316, 0),
			Size = UDim2.new(0.045, 0, 0.083, 0),
			[Roact.Event.MouseButton1Click] = function()
				self:setState({
					SortClass = Gpu,
				})
			end,
		})
		_4.FanSort = Roact.createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6656770262",
			Position = UDim2.new(0.196, 0, 0.409, 0),
			Size = UDim2.new(0.045, 0, 0.083, 0),
			[Roact.Event.MouseButton1Click] = function()
				self:setState({
					SortClass = Fan,
				})
			end,
		})
		_4.DecorSort = Roact.createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6656770949",
			Position = UDim2.new(0.196, 0, 0.588, 0),
			Size = UDim2.new(0.045, 0, 0.083, 0),
			[Roact.Event.MouseButton1Click] = function()
				self:setState({
					SortClass = Decoration,
				})
			end,
		})
		_4.GPURackSort = Roact.createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6656770631",
			Position = UDim2.new(0.196, 0, 0.499, 0),
			Size = UDim2.new(0.045, 0, 0.083, 0),
			[Roact.Event.MouseButton1Click] = function()
				self:setState({
					SortClass = Rack,
				})
			end,
		})
		_4.UtilitiesSort = Roact.createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6656771159",
			Position = UDim2.new(0.196, 0, 0.675, 0),
			Size = UDim2.new(0.045, 0, 0.083, 0),
			[Roact.Event.MouseButton1Click] = function()
				self:setState({
					SortClass = Utility,
				})
			end,
		})
		_4[_5 + 1] = Roact.createElement("UIAspectRatioConstraint", {
			AspectRatio = 1.754,
		})
		_4.DeleteItem = Roact.createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6661547244",
			Position = UDim2.new(0.506, 0, 0.767, 0),
			Size = UDim2.new(0.1, 0, 0.045, 0),
		})
		_4.MoveItem = Roact.createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6661548573",
			Position = UDim2.new(0.396, 0, 0.767, 0),
			Size = UDim2.new(0.1, 0, 0.045, 0),
		})
		return Roact.createFragment({
			InventoryFrame = Roact.createElement("Frame", _3, _4),
		})
	end
end
return {
	Inventory = Inventory,
}
