-- Compiled with roblox-ts v1.1.1
local TS = require(game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("RuntimeLib"))
-- eslint-disable prettier/prettier
local _0 = TS.import(script, TS.getModule(script, "knit").src.Knit.KnitClient)
local KnitClient = _0
local Player = _0.Player
local _1 = TS.import(script, TS.getModule(script, "services"))
local ContextActionService = _1.ContextActionService
local Players = _1.Players
local RunService = _1.RunService
local Workspace = _1.Workspace
local PlotService = TS.import(script, script.Parent, "PlotService")
local PlacementService = KnitClient.GetService("PlacementService")
local lastItem
local selectedPart
local regionOverlayPart
local partOffset
local yOffset
local rotation = 0
local placementMode = true
local handleAction
local function setSelectedPart(part)
	lastItem = part
	ContextActionService:BindAction("placeItem", handleAction, false, Enum.UserInputType.MouseButton1)
	ContextActionService:BindAction("storeItem", handleAction, false, Enum.KeyCode.X)
	ContextActionService:BindAction("exitPlaceMode", handleAction, false, Enum.KeyCode.C)
	ContextActionService:BindAction("rotateCW", handleAction, false, Enum.KeyCode.Q)
	ContextActionService:BindAction("rotateCCW", handleAction, false, Enum.KeyCode.E)
	-- Make copy
	local _2 = selectedPart
	if _2 ~= nil then
		_2:Destroy()
	end
	selectedPart = part.Model:Clone()
	Player:GetMouse().TargetFilter = selectedPart
	-- Strip scripts
	local _3 = selectedPart:GetDescendants()
	local _4 = function(element)
		if element:IsA("Script") or element:IsA("ModuleScript") or element:IsA("LocalScript") then
			element:Destroy()
		elseif element:IsA("BasePart") then
			element.CanCollide = false
			element.Transparency = .5
		end
	end
	-- ▼ ReadonlyArray.forEach ▼
	for _5, _6 in ipairs(_3) do
		_4(_6, _5 - 1, _3)
	end
	-- ▲ ReadonlyArray.forEach ▲
	-- Get offset
	selectedPart.PrimaryPart = selectedPart:FindFirstChildWhichIsA("BasePart")
	selectedPart:SetPrimaryPartCFrame(CFrame.new())
	local boundingBox = { selectedPart:GetBoundingBox() }
	partOffset = boundingBox[1].Position * (-1)
	-- Setup overlay part
	local _5 = regionOverlayPart
	if _5 ~= nil then
		_5:Destroy()
	end
	regionOverlayPart = Instance.new("Part")
	regionOverlayPart.Position = boundingBox[1].Position
	regionOverlayPart.Size = boundingBox[2]
	regionOverlayPart.Color = Color3.new(0, 1, 0)
	regionOverlayPart.Transparency = .5
	regionOverlayPart.Parent = selectedPart
	regionOverlayPart.CanCollide = false
	selectedPart.Parent = Workspace
	print(PlotService:getPlayerPlots())
	local _6 = PlotService:getPlayerPlots()
	local _7 = Players.LocalPlayer.Name
	local plotNum = _6[_7]
	if plotNum == nil then
		return nil
	end
	local _8 = game.Workspace.Plots:FindFirstChild(tostring(plotNum))
	if _8 ~= nil then
		_8 = _8:FindFirstChild("Spots")
		if _8 ~= nil then
			_8 = _8:FindFirstChild("1.1")
		end
	end
	local plotPart = _8
	yOffset = plotPart.Position.Y + (plotPart.Size.Y / 2) + (boundingBox[2].Y / 2)
end
local function setPlacementMode(m)
	placementMode = m
end
local itemPos = CFrame.new()
RunService.RenderStepped:Connect(function()
	if selectedPart == nil or partOffset == nil or placementMode == false then
		return nil
	end
	local mouseHit = Players.LocalPlayer:GetMouse().Hit
	-- Move model
	local _2 = CFrame.new(math.floor(mouseHit.Position.X * 2) / 2, yOffset, math.floor(mouseHit.Position.Z * 2) / 2)
	local _3 = CFrame.Angles(0, math.rad(90 * rotation), 0)
	itemPos = _2 * _3
	selectedPart:SetPrimaryPartCFrame(itemPos)
	-- Validate
end)
function handleAction(actionName, state, inputObject)
	if state ~= Enum.UserInputState.Begin then
		return nil
	end
	print(actionName)
	repeat
		local _2 = false
		if actionName == ("placeItem") then
			print("placeitem")
			PlacementService:placeItem(lastItem, itemPos.X, itemPos.Z, rotation)
			break
		end
		if actionName == ("storeItem") then
			break
		end
		if actionName == ("exitPlaceMode") then
			local _3 = selectedPart
			if _3 ~= nil then
				_3:Destroy()
			end
			selectedPart = nil
			local _4 = regionOverlayPart
			if _4 ~= nil then
				_4:Destroy()
			end
			regionOverlayPart = nil
			ContextActionService:UnbindAction("placeItem")
			ContextActionService:UnbindAction("storeItem")
			ContextActionService:UnbindAction("exitPlaceMode")
			break
		end
		if actionName == ("rotateCW") then
			print(rotation)
			rotation += 1
			if rotation > 3 then
				rotation = 0
			end
			break
		end
		if actionName == ("rotateCCW") then
			print(rotation)
			rotation -= 1
			if rotation < 0 then
				rotation = 3
			end
		end
	until true
end
return {
	setSelectedPart = setSelectedPart,
	setPlacementMode = setPlacementMode,
}
