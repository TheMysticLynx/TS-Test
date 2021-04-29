-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local KnitServer = TS.import(script, TS.getModule(script, "knit").src).KnitServer
local Plots = table.create(10, false)
local PlotService = KnitServer.CreateService({
	Name = "PlotService",
	PlayerPlots = {},
	getPlayerPlots = function(self)
		return KnitServer.Services.PlotService.PlayerPlots
	end,
	assignPlot = function(self, player)
		do
			local _0 = 0
			while _0 < #Plots do
				local i = _0
				if Plots[i + 1] == false then
					local _1 = self.PlayerPlots
					local _2 = player.Name
					local _3 = i
					-- ▼ Map.set ▼
					_1[_2] = _3
					-- ▲ Map.set ▲
					Plots[i + 1] = true
					return nil
				end
				_0 = i
				_0 += 1
			end
		end
		print(Plots)
		player:Kick("A error occured while assigning a plot...")
	end,
	unassignPlot = function(self, player)
		local _0 = self.PlayerPlots
		local _1 = player.Name
		local plot = _0[_1]
		if plot ~= nil then
			Plots[plot + 1] = false
			local _2 = self.PlayerPlots
			local _3 = player.Name
			-- ▼ Map.delete ▼
			_2[_3] = nil
			-- ▲ Map.delete ▲
		end
	end,
	Client = {
		getPlayerPlots = function(self)
			return KnitServer.Services.PlotService:getPlayerPlots()
		end,
	},
})
return PlotService
