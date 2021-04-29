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
			local rotation = CFrame.fromEulerAnglesYXZ((orientation:ToEulerAnglesYXZ()), (select(2, orientation:ToEulerAnglesYXZ())), (select(3, orientation:ToEulerAnglesYXZ())))
			local _7 = CFrame.new(size)
			local _8 = rotation
			local adjustedSize = (_7 * _8).Position
			-- Get 4 sides
			local sides = table.create(4)
			sides[1] = Vector3.new(orientation.Position.X - adjustedSize.X, 0, orientation.Position.Z - adjustedSize.Z)
			sides[2] = Vector3.new(orientation.Position.X + adjustedSize.X, 0, orientation.Position.Z + adjustedSize.Z)
			sides[3] = Vector3.new(orientation.Position.X - adjustedSize.X, 0, orientation.Position.Z + adjustedSize.Z)
			sides[4] = Vector3.new(orientation.Position.X + adjustedSize.X, 0, orientation.Position.Z - adjustedSize.Z)
			-- Check that all 4 corners are in plots
			local shouldBreak = false
			local _9 = sides
			local _10 = function(side)
				local passed = false
				local _11 = DataService:GetData(player)
				if _11 ~= nil then
					local _12 = _11.Plots
					local _13 = function(value, key)
						if value == true then
							local _14 = game.Workspace.Plots:FindFirstChild(tostring(plotNum))
							if _14 ~= nil then
								_14 = _14:FindFirstChild("Spots")
								if _14 ~= nil then
									-- ▼ ReadonlyArray.join ▼
									local _15 = "."
									if _15 == nil then
										_15 = ", "
									end
									-- ▲ ReadonlyArray.join ▲
									_14 = _14:FindFirstChild(table.concat(string.split(key, "_"), _15))
								end
							end
							local part = _14
							part.Color = Color3.new(math.random(), math.random(), math.random())
							if side.X > part.Position.X - (part.Size.X / 2) and side.X < part.Position.X + (part.Size.X / 2) then
								if side.Z > part.Position.Z - (part.Size.Z / 2) and side.Z < part.Position.Z + (part.Size.Z / 2) then
									passed = true
								end
							end
						end
					end
					-- ▼ ReadonlyMap.forEach ▼
					for _14, _15 in pairs(_12) do
						_13(_15, _14, _12)
					end
					-- ▲ ReadonlyMap.forEach ▲
				end
				if not passed then
					shouldBreak = true
					return nil
				end
			end
			-- ▼ ReadonlyArray.forEach ▼
			for _11, _12 in ipairs(_9) do
				_10(_12, _11 - 1, _9)
			end
			-- ▲ ReadonlyArray.forEach ▲
			if shouldBreak then
				return false
			end
			local boundsPart = Instance.new("Part")
			boundsPart.CanCollide = false
			boundsPart.Size = size
			boundsPart.CFrame = orientation
			boundsPart.Parent = Workspace
			local connection = boundsPart.Touched:Connect(function() end)
			if #boundsPart:GetTouchingParts() > 0 then
				return false
			end
			connection:Disconnect()
			boundsPart:Destroy()
			return true
		end,
	},
})
return PlacementService
