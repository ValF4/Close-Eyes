local Player: Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local HudModule = require(script.Parent.HudModule.HudModule)
local GuiControl = require(ReplicatedStorage.ClientServices.GuiControl)

local playerGui: PlayerGui = Player.PlayerGui

GuiControl:Init(Player)
HudModule:init(Player)

--local filterObjects = {}
--local boxPosition = CFrame.new(0,0,0)
--local boxSize = Vector3.new(80,80,80)
--local maxObjectsAllowed = 10
--local params = OverlapParams.new(filterObjects,Enum.RaycastFilterType.Exclude,maxObjectsAllowed,"Default")
--local objectsInSpace = workspace:GetPartBoundsInBox(boxPosition,boxSize,params)
--print(#objectsInSpace)