-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local Players = TS.import(script, TS.getModule(script, "services")).Players
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local App = TS.import(script, script.Parent, "GuiComponents", "App").App
local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
Roact.mount(Roact.createElement(App), playerGui, "RoactGUI")
--[[
	export function f<T extends Item>(player: Player, myClass: { new (): T, prototype: T }) {
	Items.forEach((element) => {
	print(element.Name)
	if (element instanceof myClass) {
	//Generate UI item
	const count = Profiles.get(player)?.Data.Items.get(element.Name)
	if (count === undefined) error("No profile")
	if (count > 0) {
	}
	}
	});
	}
]]
