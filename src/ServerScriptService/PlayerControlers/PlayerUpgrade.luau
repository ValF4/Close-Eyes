local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local InventoryMananger = require(ServerStorage.Services.InventoryMananger)
local playerupgrade = {}

function playerupgrade.upgradeInfos(PlayerID: string)
    if not PlayerID then return end
    local getPlayer: Player = Players:GetPlayerByUserId(PlayerID)
    if not getPlayer then return end
    local GetPlayerData = InventoryMananger:GetInventory(PlayerID)
    local GetPlayerLeaderstats: Folder = getPlayer:FindFirstChild("leaderstats")
    local GetPlayerConfiguration: Configuration = getPlayer.PlayerData

    GetPlayerConfiguration:SetAttribute("BrowmBottom", GetPlayerData.BrowmBottom)
    GetPlayerConfiguration:SetAttribute("GoldemBottom", GetPlayerData.GoldemBottom)

    GetPlayerLeaderstats.BrowmBottom.Value = GetPlayerData.BrowmBottom
    GetPlayerLeaderstats.GoldemBottom.Value = GetPlayerData.GoldemBottom
    GetPlayerLeaderstats.level.Value = GetPlayerData.Level
end

return playerupgrade