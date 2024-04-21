
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

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
	self.XP += Value
end

function DataMethods:setVersion(Value:string)
	if not Value then return end
	self.Config.Version = Value
end

function DataMethods:setCodeActvated(Value:string)
	if not Value then return end
	self.Config.Codes[Value] = true
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

local function GetInventory (Player)
	local InvTemp
    if typeof(Player) == "number" then
        InvTemp   = GI[Player]
    else     
        InvTemp = GI[Player.UserId]
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