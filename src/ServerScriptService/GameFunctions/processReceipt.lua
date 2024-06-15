local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local ProductList = require(ServerScriptService.ServerLists.productList)

local SucessPurchase = Bridgnet2.ServerBridge("SucessPurchase")

local FUNCTION_NAME = "[Process Receipt] "

local processReceipt = {}

function processReceipt.Process(PlayerID: Player, ProtuctID: string, Stats: {number | boolean})
    if not PlayerID or not ProtuctID then return end
    local product = ProductList[tostring(ProtuctID)]
    if not product then return end
    product(PlayerID)
    SucessPurchase:Fire(Players:GetPlayerByUserId(PlayerID), Stats)
end

return processReceipt