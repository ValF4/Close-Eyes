local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local listCodes = require(ServerScriptService.ServerLists.codeList)
local inventoryManager = require(ServerStorage.Services.InventoryMananger) 

local codeSystem = {}

function codeSystem.checkingList(Player: Player, Code: string): nil | boolean
    if not Code or not Player then return end

    local getCode: string? = listCodes[Code]

    if getCode then
        local getPlayerData = inventoryManager:GetInventory(Player)
        local getCodeActivect: {string?} = getPlayerData.Config.Codes

        if getCodeActivect[Code] then return end

        getPlayerData:setCodeActvated(tostring(Code))
        getCode(Player)

        return true
    else
        return
    end
end

return codeSystem