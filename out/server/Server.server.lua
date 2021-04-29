-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local KnitServer = TS.import(script, TS.getModule(script, "knit").src).KnitServer
local _0 = game:GetService("ServerScriptService"):FindFirstChild("TS")
if _0 ~= nil then
	_0 = _0:FindFirstChild("Services")
end
local Services = _0
if Services ~= nil then
	local _1 = Services:GetChildren()
	local _2 = function(i)
		if i:IsA("ModuleScript") then
			require(i)
			print(i.Name)
		end
	end
	-- ▼ ReadonlyArray.forEach ▼
	for _3, _4 in ipairs(_1) do
		_2(_4, _3 - 1, _1)
	end
	-- ▲ ReadonlyArray.forEach ▲
end
KnitServer.Start()
