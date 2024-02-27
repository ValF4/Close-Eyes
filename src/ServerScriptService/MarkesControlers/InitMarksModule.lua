local InitGameMarkes = {}

local PlayersPart: {} = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local InitGameMarks: Folder = workspace:WaitForChild("InitGameMarks", 5)

local ServerControlerModule = require(ServerScriptService.MarkesControlers.ServesControlersModule)
local GuiControl = require(ReplicatedStorage.ClientServices.GuiControl)
local BlueControler = require(ReplicatedStorage.ClientServices.GuiControl.GuiEffects)

local function ConectionMarks(PartName: BasePart, Part: Part): ()
	if PartName.Name == "HumanoidRootPart" then
    	local GetPlayer: Player? = Players:GetPlayerFromCharacter(PartName.Parent)
		if not GetPlayer then return end
		ServerControlerModule.ListControler(GetPlayer, Part, "ADD")
    end
end

local function LeaveMark(OtherPart: BasePart, PartMark:Part) : ()
	if OtherPart.Name == "HumanoidRootPart" then
    	local GetPlayer: Player? = Players:GetPlayerFromCharacter(OtherPart.Parent)
    	if not GetPlayer then return end
        ServerControlerModule.ListControler(GetPlayer, PartMark, "REMOVE")
	end
end

function InitGameMarkes.InitMarks(): ()
	for Index, Mark in InitGameMarks:GetChildren() do
		if Mark:IsA("Model") then
			local getChildrens: {} = Mark:GetChildren()
			for	index: number, PartMark: Part in getChildrens do
				if PartMark.Name == "Marker" then
					PartMark.Touched:Connect(function(otherPart: BasePart)
						ConectionMarks(otherPart, PartMark)
					end)
					PartMark.TouchEnded:Connect(function(otherPart: BasePart)
						LeaveMark(otherPart, PartMark)
					end)
				end
			end
		end
	end
end

return InitGameMarkes