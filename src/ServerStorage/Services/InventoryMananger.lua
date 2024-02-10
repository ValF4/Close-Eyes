
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
	self.XP += Value
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

function module:GetInventory(Player:Player|number)
	local InvTemp

	if typeof(Player) == "number" then
		InvTemp   = GI[Player]
	else     
		InvTemp = GI[Player.UserId]
	end     

	if InvTemp then
		return InvTemp
	end
end

Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoving)

return module