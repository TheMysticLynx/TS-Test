-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local HUD
do
	HUD = Roact.Component:extend("HUD")
	function HUD:init()
		self.state = {
			levelBarFill = 0,
		}
	end
	function HUD:render()
		return Roact.createFragment({
			HUD = Roact.createElement("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 1, 0),
			}, {
				Sidebar = Roact.createElement("ImageLabel", {
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundTransparency = 1,
					Image = "rbxassetid://6656522487",
					Position = UDim2.new(1, 0, 0.5, 0),
					Size = UDim2.new(0.072, 0, 0.477, 0),
				}, {
					InventoryButton = Roact.createElement("ImageButton", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://6656525961",
						Position = UDim2.new(0.171, 0, 0.045, 0),
						Size = UDim2.new(0.654, 0, 0.161, 0),
						[Roact.Event.MouseButton1Click] = self.props.InventoryButtonCallback,
					}),
					EnergyButton = Roact.createElement("ImageButton", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://6656527057",
						Position = UDim2.new(0.171, 0, 0.232, 0),
						Size = UDim2.new(0.654, 0, 0.161, 0),
						[Roact.Event.MouseButton1Click] = self.props.EnergyButtonCallback,
					}),
					ShopButton = Roact.createElement("ImageButton", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://6656528700",
						Position = UDim2.new(0.171, 0, 0.422, 0),
						Size = UDim2.new(0.654, 0, 0.161, 0),
						[Roact.Event.MouseButton1Click] = self.props.ShopButtonCallback,
					}),
					SettingsButton = Roact.createElement("ImageButton", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://6656531850",
						Position = UDim2.new(0.171, 0, 0.792, 0),
						Size = UDim2.new(0.654, 0, 0.161, 0),
						[Roact.Event.MouseButton1Click] = self.props.SettingsButtonCallback,
					}),
					CustomizeButton = Roact.createElement("ImageButton", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://6656531008",
						Position = UDim2.new(0.171, 0, 0.608, 0),
						Size = UDim2.new(0.654, 0, 0.161, 0),
						[Roact.Event.MouseButton1Click] = self.props.CustomizeButtonCallback,
					}),
					Roact.createElement("UIAspectRatioConstraint", {
						AspectRatio = 0.263,
					}),
				}),
				LevelBar = Roact.createElement("ImageLabel", {
					AnchorPoint = Vector2.new(0.5, 1),
					BackgroundTransparency = 1,
					Image = "rbxassetid://6656537672",
					Position = UDim2.new(0.5, 0, 1, -15),
					Size = UDim2.new(0.319, 0, 0.017, 0),
				}, {
					Roact.createElement("ImageLabel", {
						BackgroundTransparency = 1,
						Image = "rbxassetid://6656538559",
						Position = UDim2.new(0, 0, -0.057, 0),
						Size = UDim2.new(self.state.levelBarFill, 0, 1.067, 0),
					}),
					Roact.createElement("TextLabel", {
						BackgroundTransparency = 1,
						Font = Enum.Font.SourceSansBold,
						Position = UDim2.new(0.381, 0, -2.633, 0),
						Size = UDim2.new(0.24, 0, 2, 0),
						Text = "Level 1",
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextScaled = true,
						TextSize = 14,
						TextWrapped = true,
					}),
					Roact.createElement("UIAspectRatioConstraint", {
						AspectRatio = 33.933,
					}),
				}),
			}),
		})
	end
end
--[[
	<frame Key="HUD" BackgroundTransparency={1} Size={new UDim2(1, 0, 1, 0)}>
	<imagelabel
	Key="Sidebar"
	AnchorPoint={new Vector2(1, 0.5)}
	BackgroundTransparency={1}
	Image="rbxassetid://6656522487"
	Position={new UDim2(1, 0, 0.5, 0)}
	Size={new UDim2(0.072, 0, 0.477, 0)}
	>
	<imagebutton
	Key="InventoryButton"
	BackgroundTransparency={1}
	Image="rbxassetid://6656525961"
	Position={new UDim2(0.171, 0, 0.045, 0)}
	Size={new UDim2(0.654, 0, 0.161, 0)}
	/>
	<imagebutton
	Key="EnergyButton"
	BackgroundTransparency={1}
	Image="rbxassetid://6656527057"
	Position={new UDim2(0.171, 0, 0.232, 0)}
	Size={new UDim2(0.654, 0, 0.161, 0)}
	/>
	<imagebutton
	Key="ShopButton"
	BackgroundTransparency={1}
	Image="rbxassetid://6656528700"
	Position={new UDim2(0.171, 0, 0.422, 0)}
	Size={new UDim2(0.654, 0, 0.161, 0)}
	/>
	<imagebutton
	Key="SettingsButton"
	BackgroundTransparency={1}
	Image="rbxassetid://6656531850"
	Position={new UDim2(0.171, 0, 0.792, 0)}
	Size={new UDim2(0.654, 0, 0.161, 0)}
	/>
	<imagebutton
	Key="CustomizeButton"
	BackgroundTransparency={1}
	Image="rbxassetid://6656531008"
	Position={new UDim2(0.171, 0, 0.608, 0)}
	Size={new UDim2(0.654, 0, 0.161, 0)}
	/>
	<uiaspectratioconstraint AspectRatio={0.263} />
	</imagelabel>
	<imagelabel
	Key="LevelBar"
	AnchorPoint={new Vector2(0.5, 1)}
	BackgroundTransparency={1}
	Image="rbxassetid://6656537672"
	Position={new UDim2(0.5, 0, 1, -15)}
	Size={new UDim2(0.319, 0, 0.017, 0)}
	>
	<imagelabel
	BackgroundTransparency={1}
	Image="rbxassetid://6656538559"
	Position={new UDim2(0, 0, -0.057, 0)}
	Size={new UDim2(0, 0, 1.067, 0)}
	/>
	<textlabel
	BackgroundTransparency={1}
	Font={Enum.Font.SourceSansBold}
	Position={new UDim2(0.381, 0, -2.633, 0)}
	Size={new UDim2(0.24, 0, 2, 0)}
	Text="Level 1"
	TextColor3={Color3.fromRGB(255, 255, 255)}
	TextScaled={true}
	TextSize={14}
	TextWrapped={true}
	/>
	<uiaspectratioconstraint AspectRatio={33.933} />
	</imagelabel>
	</frame>;
]]
return {
	HUD = HUD,
}
