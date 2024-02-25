local InitGameMarkes = {}

local PlayersPart: {} = {}

local db: boolean = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local InitGameMarks: Folder = workspace:WaitForChild("InitGameMarks", 5)

local ServerControlerModule = require(ReplicatedStorage.GameServices.MarksInit.ServerControlerModule)
local GuiControl = require(ReplicatedStorage.ClientServices.GuiControl)
local BlueControler = require(ReplicatedStorage.ClientServices.GuiControl.GuiEffects)

local function ConectionMarks(PartName: BasePart, Part: Part)
	local FindCharacter: Model = PartName.Parent
    local GetPlayer: Player? = Players:GetPlayerFromCharacter(FindCharacter)
	if not GetPlayer then return end
	table.insert(PlayersPart, Part)
	if #PlayersPart >= 2 then
		if db then return end
		print("Adicionei o player")
		db = true
		ServerControlerModule.AddPlayerList(GetPlayer)
    end
end

local function LeaveMark(OtherPart: BasePart)
    local GetPlayer: Player? = Players:GetPlayerFromCharacter(OtherPart.Parent)
    if not GetPlayer then return warn("ERROR - Error for find player in playerlist") end
	table.remove(PlayersPart, table.find(PlayersPart, OtherPart))
	if #PlayersPart <= 0 then
		if not db then return end
		print("Removi o player")
        ServerControlerModule.RemovePlayerList()
		db = false
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
						LeaveMark(otherPart)
					end)
				end
			end
		end
	end
end

return InitGameMarkes