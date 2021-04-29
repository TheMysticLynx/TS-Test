-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
local ProfileService = TS.import(script, TS.getModule(script, "profileservice").src)
local ProfileStore = ProfileService.GetProfileStore("Data", {
	Money = 0,
	Items = {
		["Basic Fan"] = 1,
		["Basic Gpu"] = 1,
		["Basic Generator"] = 1,
		["Basic Rack"] = 1,
	},
	Plots = {
		["5_10"] = true,
		["5_9"] = true,
		["6_10"] = true,
		["6_9"] = true,
	},
})
if game:GetService("RunService"):IsStudio() then
	ProfileStore = ProfileStore.Mock
end
local Profiles = {}
local function initPlayer(player)
	local profile = ProfileStore:LoadProfileAsync("Player_" .. tostring(player.UserId), "ForceLoad")
	if profile then
		profile:Reconcile()
		profile:ListenToRelease(function()
			local _0 = Profiles
			local _1 = player
			-- ▼ Map.delete ▼
			_0[_1] = nil
			-- ▲ Map.delete ▲
			player:Kick("Profile was loaded in a external server. Please rejoin.")
		end)
		if player:IsDescendantOf(game:GetService("Players")) then
			local _0 = Profiles
			local _1 = player
			local _2 = profile
			-- ▼ Map.set ▼
			_0[_1] = _2
			-- ▲ Map.set ▲
			-- Callback would go here
		else
			profile:Release()
		end
	else
		player:Kick("There was a issue loading your profile")
	end
end
local function releasePlayer(player)
	local _0 = Profiles
	local _1 = player
	local _2 = _0[_1]
	if _2 ~= nil then
		_2:Release()
	end
	local _3 = Profiles
	local _4 = player
	-- ▼ Map.delete ▼
	_3[_4] = nil
	-- ▲ Map.delete ▲
end
return {
	initPlayer = initPlayer,
	releasePlayer = releasePlayer,
	Profiles = Profiles,
}
