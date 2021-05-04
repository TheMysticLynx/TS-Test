-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ProximityPromptService = TS.import(script, TS.getModule(script, "services")).ProximityPromptService
ProximityPromptService.PromptShown:Connect(function() end)
