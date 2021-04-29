-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local KnitServer = TS.import(script, TS.getModule(script, "knit").src).KnitServer
local DataModule = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "DataModule")
game:GetService("Players").PlayerAdded:Connect(function(player)
	DataModule.initPlayer(player)
	KnitServer.Services.PlotService:assignPlot(player)
	local _0 = KnitServer.Services.PlotService:getPlayerPlots()
	local _1 = player.Name
	local plot = _0[_1]
	if plot == nil then
		player:Kick("Error assigning plot.")
		return nil
	end
	-- #region Set Spawn
	-- eslint-disable-next-line prettier/prettier
	local _2 = game.Workspace.Plots:FindFirstChild(tostring(plot))
	if _2 ~= nil then
		_2 = _2:FindFirstChild("Spawn")
	end
	local respawn = _2
	local _3 = respawn
	if _3 ~= nil then
		_3 = _3.Parent
		if _3 ~= nil then
			_3 = _3.Name
		end
	end
	print(_3)
	local _4 = respawn
	if _4 ~= nil then
		_4 = _4:IsA("SpawnLocation")
	end
	if _4 then
		player.RespawnLocation = respawn
		respawn.Color = Color3.new(math.random(), math.random(), math.random())
	end
	-- #endregion
	-- Populate Inventory
	-- #region Plot Loading
	-- TODO: Plot Loading
	-- #endregion
	local _5 = DataModule.Profiles
	local _6 = player
	local _7 = _5[_6]
	if _7 ~= nil then
		_7 = _7.Data
	end
	local d = _7
	if not d or not player then
		return nil
	end
	KnitServer.Services.DataService:SetPlayerData(player, d)
end)
game:GetService("Players").PlayerRemoving:Connect(function(player)
	DataModule.releasePlayer(player)
	KnitServer.Services.PlotService:unassignPlot(player)
end)
