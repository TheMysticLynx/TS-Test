-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local KnitServer = TS.import(script, TS.getModule(script, "knit").src).KnitServer
local Workspace = TS.import(script, TS.getModule(script, "services")).Workspace
local Profiles = TS.import(script, game:GetService("ReplicatedStorage"), "TS", "DataModule").Profiles
local DataService = TS.import(script, game:GetService("ServerScriptService"), "TS", "Services", "DataService")
-- eslint-disable prettier/prettier
local PlacementService = KnitServer.CreateService({
	Name = "PlacementService",
	PlaceItem = function(self, i, x, z, r, player)
		x = math.floor(x * 2) / 2
		z = math.floor(z * 2) / 2
		-- Validate
		local model = i.Model:Clone()
		model.PrimaryPart = model:FindFirstChildWhichIsA("BasePart")
		model:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
		local _0 = model.PrimaryPart
		if _0 ~= nil then
			_0 = _0.Position
		end
		local offset = _0
		local _1 = KnitServer.Services.PlotService:getPlayerPlots()
		local _2 = player.Name
		local plotNum = _1[_2]
		if plotNum == nil then
			return nil
		end
		local _3 = game.Workspace.Plots:FindFirstChild(tostring(plotNum))
		if _3 ~= nil then
			_3 = _3:FindFirstChild("Spots")
			if _3 ~= nil then
				_3 = _3:FindFirstChild("1.1")
			end
		end
		local plotPart = _3
		local yOffset = plotPart.Position.Y + (plotPart.Size.Y / 2) + ((select(2, model:GetBoundingBox())).Y / 2)
		local _4 = model
		local _5 = CFrame.new(math.floor(x * 2) / 2, yOffset, math.floor(z * 2) / 2)
		local _6 = CFrame.Angles(0, math.rad(90 * r), 0)
		_4:SetPrimaryPartCFrame(_5 * _6)
		if not self.Client:ValidatePlace(player, model, r) then
			model:Destroy()
			return nil
		end
		-- Take from inventory
		-- Place
		model.Parent = Workspace
	end,
	Client = {
		placeItem = function(self, player, i, x, z, r)
			KnitServer.Services.PlacementService:PlaceItem(i, x, z, r, player)
		end,
		ValidatePlace = function(self, player, model, r)
			-- make model
			local _0 = model.PrimaryPart
			if _0 ~= nil then
				_0 = _0.Position
			end
			local offset = _0
			local _1 = KnitServer.Services.PlotService:getPlayerPlots()
			local _2 = player.Name
			local plotNum = _1[_2]
			if plotNum == nil then
				return false
			end
			local _3 = game.Workspace.Plots:FindFirstChild(tostring(plotNum))
			if _3 ~= nil then
				_3 = _3:FindFirstChild("Spots")
				if _3 ~= nil then
					_3 = _3:FindFirstChild("1.1")
				end
			end
			local plotPart = _3
			local yOffset = plotPart.Position.Y + (plotPart.Size.Y / 2) + ((select(2, model:GetBoundingBox())).Y / 2)
			-- Check inventory
			local _4 = Profiles
			local _5 = player
			local _6 = _4[_5]
			if _6 ~= nil then
				local _7 = _6.Data.Items
				local _8 = model.Name
				_6 = _7[_8]
			end
			local itemCount = _6
			-- eslint-disable-next-line roblox-ts/lua-truthiness
			if not (itemCount ~= 0 and itemCount == itemCount and itemCount) then
				return false
			end
			local orientation = (model:GetBoundingBox())
			local size = (select(2, model:GetBoundingBox()))
			if r == 1 or r == 3 then
				size = Vector3.new(size.Z, size.Y, size.X)
			end
			-- Get 4 sides
			local sides = table.create(4)
			sides[1] = Vector3.new(orientation.Position.X - size.X, 0, orientation.Position.Z - size.Z)
			sides[2] = Vector3.new(orientation.Position.X + size.X, 0, orientation.Position.Z + size.Z)
			sides[3] = Vector3.new(orientation.Position.X - size.X, 0, orientation.Position.Z + size.Z)
			sides[4] = Vector3.new(orientation.Position.X + size.X, 0, orientation.Position.Z - size.Z)
			-- Check that all 4 corners are in plots
			local shouldBreak = false
			local _7 = sides
			local _8 = function(side)
				local passed = false
				local _9 = DataService:GetData(player)
				if _9 ~= nil then
					local _10 = _9.Plots
					local _11 = function(value, key)
						if value == true then
							local _12 = game.Workspace.Plots:FindFirstChild(tostring(plotNum))
							if _12 ~= nil then
								_12 = _12:FindFirstChild("Spots")
								if _12 ~= nil then
									-- ▼ ReadonlyArray.join ▼
									local _13 = "."
									if _13 == nil then
										_13 = ", "
									end
									-- ▲ ReadonlyArray.join ▲
									_12 = _12:FindFirstChild(table.concat(string.split(key, "_"), _13))
								end
							end
							local part = _12
							part.Color = Color3.new(math.random(), math.random(), math.random())
							print("AA")
							print(side.X, " ", part.Position.X - (part.Size.X / 2))
							print(side.X, " ", part.Position.X + (part.Size.X / 2))
							print(side.Z, " ", part.Position.Z - (part.Size.Z / 2))
							print(side.Z, " ", part.Position.Z + (part.Size.Z / 2))
							if side.X > part.Position.X - (part.Size.X / 2) and side.X < part.Position.X + (part.Size.X / 2) then
								if side.Z > part.Position.Z - (part.Size.Z / 2) and side.Z < part.Position.Z + (part.Size.Z / 2) then
									passed = true
									print("TEst")
								end
							end
						end
					end
					-- ▼ ReadonlyMap.forEach ▼
					for _12, _13 in pairs(_10) do
						_11(_13, _12, _10)
					end
					-- ▲ ReadonlyMap.forEach ▲
				end
				if not passed then
					shouldBreak = true
					return nil
				end
			end
			-- ▼ ReadonlyArray.forEach ▼
			for _9, _10 in ipairs(_7) do
				_8(_10, _9 - 1, _7)
			end
			-- ▲ ReadonlyArray.forEach ▲
			if shouldBreak then
				return false
			end
			-- Check no parts in region
			local _9 = orientation.Position
			local _10 = size / 2
			local _11 = _9 - _10
			local _12 = orientation.Position
			local _13 = size / 2
			local region = Region3.new(_11, _12 + _13)
			if not plotPart.Parent then
				return false
			end
			local ignoreList = table.create(1, plotPart.Parent)
			if #Workspace:FindPartsInRegion3WithIgnoreList(region, ignoreList) > 0 then
				return false
			end
			return true
		end,
	},
})
return PlacementService
