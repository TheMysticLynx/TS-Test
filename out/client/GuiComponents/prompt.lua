-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local Prompt
do
	Prompt = Roact.Component:extend("Prompt")
	function Prompt:init()
	end
	function Prompt:render()
		return Roact.createFragment({
			Prompt = Roact.createElement("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Size = UDim2.new(1, 0, 1, 0),
			}, {
				Roact.createElement("Frame", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.304, 0, 0.628, 0),
				}, {
					Prompt = Roact.createElement("ImageLabel", {
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundTransparency = 1,
						Image = "rbxassetid://6760300420",
						Position = UDim2.new(0.5, 0, 0, 0),
						Size = UDim2.new(1, 0, 0.619, 0),
					}, {
						Buy = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Roboto,
							Position = UDim2.new(0, 0, 0.049, 0),
							Size = UDim2.new(1, 0, 0.116, 0),
							Text = "  Buy",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextWrapped = true,
							TextXAlignment = Enum.TextXAlignment.Left,
						}),
						["Item Name"] = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Roboto,
							Position = UDim2.new(0, 0, 0.259, 0),
							Size = UDim2.new(1, 0, 0.101, 0),
							Text = self.props.name,
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextWrapped = true,
						}),
						Description = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Roboto,
							Position = UDim2.new(0.214, 0, 0.36, 0),
							Size = UDim2.new(0.571, 0, 0.304, 0),
							Text = self.props.description,
							TextColor3 = Color3.fromRGB(188, 188, 188),
							TextScaled = true,
							TextSize = 20,
							TextTruncate = Enum.TextTruncate.AtEnd,
							TextWrapped = true,
						}),
						Roact.createElement("ImageLabel", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							Image = "rbxassetid://6656675417",
							Position = UDim2.new(0.2, 0, 0.727, 0),
							Size = UDim2.new(0.078, 0, 0.128, 0),
						}, {
							Roact.createElement("UIAspectRatioConstraint"),
						}),
						Roact.createElement("ImageLabel", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							Image = "rbxassetid://6656680129",
							Position = UDim2.new(0.5, 0, 0.731, 0),
							Size = UDim2.new(0.069, 0, 0.113, 0),
						}, {
							Roact.createElement("UIAspectRatioConstraint"),
						}),
						Cost = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Roboto,
							Position = UDim2.new(0, 0, 0.929, 0),
							Size = UDim2.new(1, 0, 0.071, 0),
							Text = self.props.cost,
							TextColor3 = Color3.fromRGB(0, 255, 59),
							TextScaled = true,
							TextSize = 14,
							TextWrapped = true,
						}),
						Roact.createElement("ImageLabel", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1,
							Image = "rbxassetid://6762466084",
							Position = UDim2.new(0.8, 0, 0.722, 0),
							Size = UDim2.new(0.031, 0, 0.113, 0),
						}, {
							Roact.createElement("UIAspectRatioConstraint", {
								AspectRatio = 0.444,
							}),
						}),
						Usage = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Roboto,
							Position = UDim2.new(0.35, 0, 0.809, 0),
							Size = UDim2.new(0.3, 0, 0.071, 0),
							Text = self.props.usage,
							TextColor3 = Color3.fromRGB(195, 195, 195),
							TextScaled = true,
							TextSize = 14,
							TextWrapped = true,
						}),
						RoCoin = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Roboto,
							Position = UDim2.new(0.048, 0, 0.809, 0),
							Size = UDim2.new(0.3, 0, 0.071, 0),
							Text = self.props.rocoin,
							TextColor3 = Color3.fromRGB(195, 195, 195),
							TextScaled = true,
							TextSize = 14,
							TextWrapped = true,
						}),
						Temp = Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Roboto,
							Position = UDim2.new(0.649, 0, 0.809, 0),
							Size = UDim2.new(0.3, 0, 0.071, 0),
							Text = self.props.temp,
							TextColor3 = Color3.fromRGB(195, 195, 195),
							TextScaled = true,
							TextSize = 14,
							TextWrapped = true,
						}),
					}),
					["Push Button"] = Roact.createElement("ImageLabel", {
						AnchorPoint = Vector2.new(0.5, 1),
						BackgroundTransparency = 1,
						Image = "rbxassetid://6760300502",
						Position = UDim2.new(0.5, 0, 1, 0),
						Size = UDim2.new(0.3, 0, 0.253, 0),
						Transparency = self.props.transparency,
					}, {
						Roact.createElement("TextLabel", {
							BackgroundTransparency = 1,
							Font = Enum.Font.Roboto,
							Size = UDim2.new(1, 0, 1, 0),
							Text = "E",
							TextColor3 = Color3.fromRGB(255, 255, 255),
							TextScaled = true,
							TextSize = 14,
							TextWrapped = true,
							Transparency = self.props.transparency,
						}),
					}),
					Roact.createElement("UIAspectRatioConstraint", {
						AspectRatio = 0.845,
					}),
				}),
			}),
		})
	end
end
return {
	Prompt = Prompt,
}
