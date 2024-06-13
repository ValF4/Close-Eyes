local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local ProductList = require(ServerScriptService.ServerLists.productList)

local FUNCTION_NAME = "[Process Receipt] "

local processReceipt = {}

function processReceipt.Process(playerID: Player, ProtuctID: string)
    if not playerID or not ProtuctID then return end
    local product = ProductList[tostring(ProtuctID)]
    if not product then return end
    product(playerID)
end

return processReceipt