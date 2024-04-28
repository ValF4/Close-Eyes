local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local InventoryMananger = require(ServerStorage.Services.InventoryMananger)

local exchangeVersion = Bridgnet2.ReferenceBridge("exchangeVersion")

local ChekingUpgrade = {}

function ChekingUpgrade.GetVersion() return ServerStorage.serverInfo:GetAttribute("Version") end

function ChekingUpgrade.Cheking(Player: Player): ()

    if not Player then return end

    local GetVersion: string = ServerStorage.serverInfo:GetAttribute("Version")
    local GetPlayerData = InventoryMananger:GetInventory(Player)
    if not GetPlayerData then return end

    local GetPlayerVersion: string = GetPlayerData.Config.Version

   -- if GetPlayerVersion == GetVersion then return end
 
    GetPlayerData:setVersion(GetVersion)

    exchangeVersion:Fire(Player, GetVersion)
end

return ChekingUpgrade