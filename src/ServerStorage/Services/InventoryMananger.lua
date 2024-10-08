local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local TITLE_FUNCTION = "[Inventory Manager] -"

local DataMananger = require(ServerStorage.Services.DataMananger)
GI = require(ServerStorage.Services.SubServices.Inventorys)

local DataMethods:DataMananger.ProfileType = {}
DataMethods.__index = DataMethods

function PlayerInit(Profile,Player:Player)

	local data = setmetatable({},DataMethods)
	data.__index = data
	data.Owner = Player

	return setmetatable(Profile,data)
end
--------------------------------//--------------------------------------

--[[function DataMethods:teste()
	self.propriedade --- função
end]]

function DataMethods:Addxp(Value:number)
	if not Value then return end
	self.Xp += Value
end

function DataMethods:addlevel(Value:number)
	if not Value then return end
	self.Level += Value
end

function DataMethods:setVersion(Value:string)
	if not Value then return end
	self.Config.Version = Value
end

function DataMethods:setCodeActvated(Value:string)
	if not Value then return end
	self.Config.Codes[Value] = true
end

function DataMethods:equipMask(Value:string)
	if not Value then return end
	self.CurrentMask = Value
end

function DataMethods:setItenInInventory(Value:number, Type: string)
	if not Value or not Type then warn(`{TITLE_FUNCTION} Valor para adicionar item no inventario não encaminhado.`) return end
	table.insert(self.Inventory[Type], Value)
end

function DataMethods:removeGiftInInventory(index:number)
	if not index then warn(`{TITLE_FUNCTION} Valor para remover o item dos presentes não encaminhado.`) return end
	table.remove(self.Inventory.Gifts, index)
end

function DataMethods:setGoldenBottons(Value:number)
	if not Value then warn(`{TITLE_FUNCTION} Valor para adicionar Goldem Bottom não encaminhado.`) return end
	self.GoldemBottom += Value
end

function DataMethods:setBrowmBottons(Value:number)
	if not Value then warn(`{TITLE_FUNCTION} Valor para adicionar Goldem Bottom não encaminhado.`) return end
	self.BrowmBottom += Value
end

function DataMethods:setReceived(index:number, Value: boolean)
	if not index or not Value then warn(`{TITLE_FUNCTION} Valor para adicionar Goldem Bottom não encaminhado.`) return end
	self.Missions[index].received = Value
end

function DataMethods:setLastEntry(Value: number)
	if not Value then warn(`{TITLE_FUNCTION} O valor de Tick não foi enviado para a função.`) return end
	self.lastEntry = Value
end

function DataMethods:SetProcress(location: number ,Value: number)
	if not Value then warn(`{TITLE_FUNCTION} O valor de Tick não foi enviado para a função.`) return end
	self.Missions[location].Progress = Value
end

function DataMethods:SetMission(Value)
	if not Value then warn(`{TITLE_FUNCTION} O valor de missões não foi enviado para a função`) return end
	table.insert(self.Missions, Value)
end

function DataMethods:RemoveMission(Value)
	if not Value then warn(`{TITLE_FUNCTION} O valor de missões não foi enviado para a função`) return end
	self.Missions[Value] = nil
end

--------------------------------//--------------------------------------
module = {}

function module:Init()
	GI = {}
end

function PlayerAdded(Player)
	GI[Player.UserId] = PlayerInit(DataMananger:GetData(Player),Player)
end

function PlayerRemoving(Player)
	GI[Player.UserId] = nil
end

local function GetInventory(Player)
	local InvTemp
    if typeof(Player) == "number" then
        InvTemp = GI[Player]
    else     
        InvTemp	= GI[Player.UserId]
    end     

    return InvTemp
end

function module:GetInventory(Player:Player|number)
	local Inventory

	while not Inventory do task.wait()
		Inventory = GetInventory(Player)
		if Inventory then return Inventory end
	end

end

Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoving)

return module