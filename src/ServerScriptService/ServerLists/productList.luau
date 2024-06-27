local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local InventoryMananger = require(ServerStorage.Services.InventoryMananger)
local PlayerUpgrade = require(ServerScriptService.PlayerControlers.PlayerUpgrade)
local MissionModule = require(ServerScriptService.PlayerControlers.MissionModule)

local FUNCTION_TITLE: string = "[Product List Process] -"
local MissionReference: string = "GoldemCollet"

local ProductValues = {
    ['1845872803'] = 100,
    ['1845882822'] = 600,
    ['1845884418'] = 1750,
    ['1845886313'] = 3000
} 

local function ProductAdministrator(PlayerID: string, Value: number)
    if not PlayerID then warn(`{FUNCTION_TITLE} Valor de player não foi enviado para a função.`) return end
    local getPlayerInventory = InventoryMananger:GetInventory(PlayerID)
    getPlayerInventory:setGoldenBottons(Value, PlayerID)
    PlayerUpgrade.upgradeInfos(PlayerID)
    MissionModule.CheckingMissionsStatus(Value, PlayerID, MissionReference)
end

local productList = {
    ['1845872803'] = function(playerID: string) ProductAdministrator(playerID, ProductValues["1845872803"]) end, -- Compra de 100 Goldem Bottons

    ['1845882822'] = function(playerID: string) ProductAdministrator(playerID, ProductValues["1845882822"]) end, -- Compra de 500 Goldem Bottons + 100 de bonus

    ['1845884418'] = function(playerID: string) ProductAdministrator(playerID, ProductValues["1845884418"]) end, -- Compra de 1500 Goldem Bottons + 250 de bonus

    ['1845886313'] = function(playerID: string) ProductAdministrator(playerID, ProductValues["1845886313"]) end, -- Compra de 2500 Goldem Bottons + 500 de bonus

}

return productList