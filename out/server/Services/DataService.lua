-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local _0 = TS.import(script, TS.getModule(script, "knit").src)
local KnitServer = _0.KnitServer
local RemoteSignal = _0.RemoteSignal
local Profiles = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "DataModule").Profiles
local DataService = KnitServer.CreateService({
	Name = "DataService",
	GetData = function(self, player)
		local _1 = Profiles
		local _2 = player
		local _3 = _1[_2]
		if _3 ~= nil then
			_3 = _3.Data
		end
		return _3
	end,
	Client = {
		dataChanged = RemoteSignal.new(),
		GetData = function(self, player)
			return KnitServer.Services.DataService:GetData(player)
		end,
	},
	SetPlayerData = function(self, player, data)
		local _1 = Profiles
		local _2 = player
		local d = _1[_2]
		if not d or not d.Data then
			return nil
		end
		d.Data = data
		self.Client.dataChanged:Fire(player, data)
	end,
})
return DataService
