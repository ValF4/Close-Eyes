local InitShopSystem = {}

local PlayersPart: {} = {}

local db: boolean = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Marks: Folder = workspace:WaitForChild("Markers") 

local Shoplist = require(script.ShopList)	
local GuiControl = require(ReplicatedStorage.ClientServices.GuiControl)

local function ConectionMarks(PartName: BasePart, Part: Part)
	local FindPlayer = PartName.Parent
	if not Players:GetPlayerFromCharacter(FindPlayer) then return end
	table.insert(PlayersPart, Part)
	if #PlayersPart >= 2 then
		if db then return end
		db = true
		for index: string?, func in Shoplist do
			if index == Part.Parent.Name then func(FindPlayer) end
		end
	end
end

local function LeaveMark(OtherPart: BasePart)
	table.remove(PlayersPart, table.find(PlayersPart, OtherPart))
	if #PlayersPart <= 0 then
		if not db then return end
		GuiControl.RemoveGuiInScreem()
		db = false
	end
end

--local function depurefunc()
--	while true do task.wait(1)
--		print(PlayersPart)
--	end
--end

function InitShopSystem.InitShop(): ()
	for Index, Mark in Marks:GetChildren() do
		if Mark:IsA("Model") then
			local getChildrens: {} = Mark:GetChildren()
			for	index: number, PartMark: Part in getChildrens  do
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

return InitShopSystem