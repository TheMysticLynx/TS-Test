-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local KnitClient = TS.import(script, TS.getModule(script, "knit").src).KnitClient
return KnitClient.GetService("DataService")
