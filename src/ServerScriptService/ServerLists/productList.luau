local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local InventoryMananger = require(ServerStorage.Services.InventoryMananger)

local FUNCTION_TITLE = "[Product List Process] -"

local productList = {
    ['1845872803'] = function(playerID: Player) -- Compra de 100 Goldem Bottons
        local productValue = 100
        if not playerID then warn(`{FUNCTION_TITLE} Valor de player não foi enviado para a função.`) return end
        local getPlayerInventory = InventoryMananger:GetInventory(playerID)
        getPlayerInventory:setGoldenBottons(productValue)
    end,

    ['1845882822'] = function(playerID: Player) -- Compra de 500 Goldem Bottons + 100 de bonus
        local productValue = 600
        if not playerID then warn(`{FUNCTION_TITLE} Valor de player não foi enviado para a função.`) return end
        local getPlayerInventory = InventoryMananger:GetInventory(playerID)
        getPlayerInventory:setGoldenBottons(productValue)
    end,

    ['1845884418'] = function(playerID: Player) -- Compra de 1500 Goldem Bottons + 250 de bonus
        local productValue = 1750
        if not playerID then warn(`{FUNCTION_TITLE} Valor de player não foi enviado para a função.`) return end
        local getPlayerInventory = InventoryMananger:GetInventory(playerID)
        getPlayerInventory:setGoldenBottons(productValue)
    end,

    ['1845886313'] = function(playerID: Player) -- Compra de 2500 Goldem Bottons + 500 de bonus
        local productValue = 3000
        if not playerID then warn(`{FUNCTION_TITLE} Valor de player não foi enviado para a função.`) return end
        local getPlayerInventory = InventoryMananger:GetInventory(playerID)
        getPlayerInventory:setGoldenBottons(productValue)
    end,
}

return productList