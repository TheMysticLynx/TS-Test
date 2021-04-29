-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local InventoryItem
do
	InventoryItem = Roact.Component:extend("InventoryItem")
	function InventoryItem:init(props)
		self.state = {
			selected = false,
		}
		self.viewportRef = Roact.createRef()
		self.debounce = false
	end
	function InventoryItem:didMount()
		local camera = Instance.new("Camera")
		local viewport = self.viewportRef:getValue()
		local model = self.props.item.Model:Clone()
		model.PrimaryPart = model:FindFirstChildWhichIsA("BasePart")
		model:SetPrimaryPartCFrame(CFrame.new())
		model:SetPrimaryPartCFrame(CFrame.new((model:GetBoundingBox()).Position * (-1)))
		model.Parent = viewport
		if viewport == nil then
			error("This is a problem.")
		end
		camera.Parent = viewport
		viewport.CurrentCamera = camera
		local zoom = (select(2, model:GetBoundingBox())).Magnitude * .75
		camera.CFrame = CFrame.new(Vector3.new(zoom, zoom, 0), Vector3.new(0, 0, 0))
		spawn(function()
			while { wait(.05) } do
				local _0, _1 = TS.try(function()
					local _2 = model
					local _3 = model:GetPrimaryPartCFrame()
					local _4 = CFrame.fromEulerAnglesXYZ(0, .05, 0)
					_2:SetPrimaryPartCFrame(_3 * _4)
				end, function(error)
					return TS.TRY_BREAK
				end)
				if _0 then
					break
				end
			end
		end)
	end
	function InventoryItem:didUpdate(pProps, pState)
		if pState.selected and self.state.selected then
			self:setState({
				selected = false,
			})
		end
	end
	function InventoryItem:render()
		local BGTransparency = self.state.selected and .5 or 1
		if self.state.selected then
			local camera = Instance.new("Camera")
			local viewport = self.props.previewRef:getValue()
			local _0 = viewport
			if _0 ~= nil then
				_0:ClearAllChildren()
			end
			local model = self.props.item.Model:Clone()
			model.PrimaryPart = model:FindFirstChildWhichIsA("BasePart")
			model:SetPrimaryPartCFrame(CFrame.new())
			model:SetPrimaryPartCFrame(CFrame.new((model:GetBoundingBox()).Position * (-1)))
			model.Parent = viewport
			if viewport == nil then
				error("This is a problem.")
			end
			camera.Parent = viewport
			viewport.CurrentCamera = camera
			local zoom = (select(2, model:GetBoundingBox())).Magnitude * .75
			camera.CFrame = CFrame.new(Vector3.new(zoom, zoom, 0), Vector3.new(0, 0, 0))
			spawn(function()
				while { wait(.05) } do
					local _1, _2 = TS.try(function()
						local _3 = model
						local _4 = model:GetPrimaryPartCFrame()
						local _5 = CFrame.fromEulerAnglesXYZ(0, .05, 0)
						_3:SetPrimaryPartCFrame(_4 * _5)
					end, function(error)
						return TS.TRY_BREAK
					end)
					if _1 then
						break
					end
				end
			end)
		end
		return Roact.createFragment({
			Selection = Roact.createElement("ImageButton", {
				BackgroundTransparency = 1,
				Image = "rbxassetid://6656697737",
				Size = UDim2.new(0.178, 0, 0.286, 0),
				[Roact.Event.MouseButton1Click] = function()
					self.props.MouseButtonClick()
					self:setState({
						selected = true,
					})
				end,
			}, {
				Count = Roact.createElement("TextLabel", {
					BackgroundTransparency = 1,
					Font = Enum.Font.SourceSans,
					Size = UDim2.new(0.35, 0, 0.35, 0),
					Text = tostring(self.props.count),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextScaled = true,
					TextSize = 14,
					TextStrokeTransparency = 0,
					TextWrapped = true,
				}),
				Roact.createElement("ViewportFrame", {
					[Roact.Ref] = self.viewportRef,
					BackgroundTransparency = BGTransparency,
					Position = UDim2.new(0.095, 0, 0.095, 0),
					Size = UDim2.new(0.8, 0, 0.8, 0),
				}),
			}),
		})
	end
end
return {
	InventoryItem = InventoryItem,
}
