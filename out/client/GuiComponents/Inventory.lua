-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local _0 = TS.import(script, TS.getModule(script, "roact").src)
local Roact = _0
local createBinding = _0.createBinding
local TweenService = TS.import(script, TS.getModule(script, "services")).TweenService
local ClientDataService = TS.import(script, script.Parent.Parent, "Modules", "ClientDataService")
local setSelectedPart = TS.import(script, script.Parent.Parent, "Modules", "PlacementManager").setSelectedPart
local Item = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Item").Item
local _1 = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "Items")
local Decoration = _1.Decoration
local Fan = _1.Fan
local Gpu = _1.Gpu
local Items = _1.Items
local Placeable = _1.Placeable
local Rack = _1.Rack
local Utility = _1.Utility
local InventoryItem = TS.import(script, script.Parent, "InventoryItem").InventoryItem
local Inventory
do
	Inventory = Roact.Component:extend("Inventory")
	function Inventory:init(props)
		local _2 = {
			show = false,
			BtcSText = 0,
			PowerUsageText = 0,
			SellPriceText = 0,
			ItemName = "N/A",
			SortClass = Item,
		}
		local _3 = "Inventory"
		local _4 = ClientDataService:GetData()
		if _4 ~= nil then
			_4 = _4.Items
		end
		_2[_3] = _4
		self.state = _2
		self.viewPortRef = Roact.createRef()
		self.frameRef = Roact.createRef()
		self.animAlphaBinding = { createBinding(1) }
	end
	function Inventory:setVisibility(v)
		self:setState({
			show = v,
		})
	end
	function Inventory:getItems(myClass)
		local items = {}
		local _2 = Items
		local _3 = function(v)
			local _4 = self.state.Inventory
			if _4 ~= nil then
				local _5 = v.Name
				_4 = _4[_5]
			end
			local count = _4
			local _5 = false
			if type(v) == "table" then
				local _6 = getmetatable(v)
				while _6 ~= nil do
					if _6 == myClass then
						_5 = true
						break
					else
						local _7 = getmetatable(_6)
						if _7 then
							_6 = _7.__index
						else
							break
						end
					end
				end
			end
			local _6 = _5
			if _6 then
				_6 = count ~= nil and count > 0
			end
			if _6 then
				local _7 = items
				local _8 = {
					i = v,
					c = count,
				}
				-- ▼ Array.push ▼
				_7[#_7 + 1] = _8
				-- ▲ Array.push ▲
			end
		end
		-- ▼ ReadonlyMap.forEach ▼
		for _4, _5 in pairs(_2) do
			_3(_5, _4, _2)
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
	function Inventory:didUpdate(prevProps, prevState)
		if prevState.show == self.state.show then
			return nil
		end
		local frame = self.frameRef:getValue()
		local target = self.state.show and 1 or 0
		if frame ~= nil then
			frame.Visible = true
			local goal = {
				Size = UDim2.new(target, 0, target, 0),
			}
			local options = TweenInfo.new(.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
			local tween = TweenService:Create(frame, options, goal)
			tween:Play()
			if not self.state.show then
				tween.Completed:Connect(function()
					frame.Visible = false
				end)
			end
		end
	end
	function Inventory:render()
		local ItemFrames = {}
		local _2 = self:getItems(self.state.SortClass)
		local _3 = function(v)
			local newState = {
				BtcSText = 0,
				PowerUsageText = 0,
				SellPriceText = v.i.Cost * .75,
				ItemName = v.i.Name,
			}
			local _4 = false
			if type(v) == "table" then
				local _5 = getmetatable(v)
				while _5 ~= nil do
					if _5 == Gpu then
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
			if _4 then
				newState.BtcSText = v.RoCoinPerSec
				newState.PowerUsageText = v.PowerUsage
			end
			local _5 = ItemFrames
			local _6 = Roact.createFragment({
				[v.i.Name] = Roact.createElement(InventoryItem, {
					count = v.c,
					item = v.i,
					previewRef = self.viewPortRef,
					MouseButtonClick = function()
						self:setState(newState)
						local _7 = v.i
						local _8 = false
						if type(_7) == "table" then
							local _9 = getmetatable(_7)
							while _9 ~= nil do
								if _9 == Placeable then
									_8 = true
									break
								else
									local _10 = getmetatable(_9)
									if _10 then
										_9 = _10.__index
									else
										break
									end
								end
							end
						end
						if _8 then
							setSelectedPart(v.i)
						end
					end,
				}),
			})
			-- ▼ Array.push ▼
			_5[#_5 + 1] = _6
			-- ▲ Array.push ▲
		end
		-- ▼ ReadonlyArray.forEach ▼
		for _4, _5 in ipairs(_2) do
			_3(_5, _4 - 1, _2)
		end
		-- ▲ ReadonlyArray.forEach ▲
		local _4 = {
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1, 0, 1, 0),
			Visible = false,
			[Roact.Ref] = self.frameRef,
		}
		local _5 = {}
		local _6 = #_5
		local _7 = {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6656665774",
			Position = UDim2.new(0.246, 0, 0.242, 0),
			Size = UDim2.new(0.507, 0, 0.517, 0),
		}
		local _8 = {
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
		local _9 = #_8
		local _10 = {
			Active = true,
			BackgroundTransparency = 1,
			Position = UDim2.new(0.271, 0, 0.187, 0),
			Size = UDim2.new(0.694, 0, 0.745, 0),
		}
		local _11 = {}
		local _12 = #_11
		for _13, _14 in ipairs(ItemFrames) do
			_11[_12 + _13] = _14
		end
		_12 = #_11
		_11[_12 + 1] = Roact.createElement("UIGridLayout", {
			CellPadding = UDim2.new(0, 10, 0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})
		_8[_9 + 1] = Roact.createElement("ScrollingFrame", _10, _11)
		_8[_9 + 2] = Roact.createElement("UIAspectRatioConstraint", {
			AspectRatio = 1.721,
		})
		_5.Frame = Roact.createElement("ImageLabel", _7, _8)
		_5.GpuSort = Roact.createElement("ImageButton", {
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
		_5.FanSort = Roact.createElement("ImageButton", {
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
		_5.DecorSort = Roact.createElement("ImageButton", {
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
		_5.GPURackSort = Roact.createElement("ImageButton", {
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
		_5.UtilitiesSort = Roact.createElement("ImageButton", {
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
		_5[_6 + 1] = Roact.createElement("UIAspectRatioConstraint", {
			AspectRatio = 1.754,
		})
		_5.DeleteItem = Roact.createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6661547244",
			Position = UDim2.new(0.506, 0, 0.767, 0),
			Size = UDim2.new(0.1, 0, 0.045, 0),
		})
		_5.MoveItem = Roact.createElement("ImageButton", {
			BackgroundTransparency = 1,
			Image = "rbxassetid://6661548573",
			Position = UDim2.new(0.396, 0, 0.767, 0),
			Size = UDim2.new(0.1, 0, 0.045, 0),
		})
		return Roact.createFragment({
			InventoryFrame = Roact.createElement("Frame", _4, _5),
		})
	end
end
return {
	Inventory = Inventory,
}
