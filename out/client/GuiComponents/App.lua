-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local Roact = TS.import(script, TS.getModule(script, "roact").src)
local HUD = TS.import(script, script.Parent, "Hud").HUD
local Inventory = TS.import(script, script.Parent, "Inventory").Inventory
local App
do
	App = Roact.Component:extend("App")
	function App:init(props)
		self.state = {
			HUDVisible = true,
			InventoryVisible = false,
		}
	end
	function App:render()
		return Roact.createElement("ScreenGui", {
			ResetOnSpawn = false,
			Enabled = self.state.HUDVisible,
		}, {
			Roact.createElement(HUD, {
				ShopButtonCallback = function()
					local _0 = self.inventoryRef
					if _0 ~= nil then
						_0:setVisibility(false)
					end
				end,
				EnergyButtonCallback = function()
					local _0 = self.inventoryRef
					if _0 ~= nil then
						_0:setVisibility(false)
					end
				end,
				CustomizeButtonCallback = function()
					local _0 = self.inventoryRef
					if _0 ~= nil then
						_0:setVisibility(false)
					end
				end,
				SettingsButtonCallback = function()
					local _0 = self.inventoryRef
					if _0 ~= nil then
						_0:setVisibility(false)
					end
				end,
				InventoryButtonCallback = function()
					local _0 = self.inventoryRef
					if _0 ~= nil then
						local _1 = self.inventoryRef
						if _1 ~= nil then
							_1 = _1.state.show
						end
						_0:setVisibility(not _1)
					end
				end,
			}),
			Roact.createElement(Inventory, {
				SetRef = function(i)
					print(i)
					self.inventoryRef = i
				end,
			}),
		})
	end
end
return {
	App = App,
}
