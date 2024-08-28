local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local luckModule = require(ServerScriptService.PlayerControlers.giftSystem)
local InventoryManager = require(ServerStorage.Services.InventoryMananger)

local MODULE_NAME: string = "[Inventory Controler]"

local inventoryControler = {}

local InitMask = "BAGMASK"

local Masks = {
    BAGMASK     = {ID = "BAGMASK", Name = "Bag mask", Rarity = "commun"},
    SPIDERMASK  = {ID = "SPIDERMASK", Name = "Spider mask", Rarity = "uncommon"},
    HAIRMASK    = {ID = "HAIRMASK", Name = "Hair mask", Rarity = "rare"},
    CACTUSMASK  = {ID = "CACTUSMASK", Name = "Cactus mask", Rarity = "legendary"}
}

function inventoryControler.CheckingNewPlayer(Player: Player): ()
    if not Player then return end
    local PlayerData = InventoryManager:GetInventory(Player)
    if not PlayerData then return end
    if PlayerData.CurrentMask == "" or PlayerData == nil then inventoryControler.ReplaceMask(Player, InitMask) end
    if table.getn(PlayerData.Inventory.Masks) ~= 0 then return end
    PlayerData:setItenInInventory(InitMask, "Masks")
    inventoryControler.ReplaceMask(Player, InitMask)
end

function inventoryControler.AddItem(Player: Player, Item: string): boolean?
    if not Item then warn(`{MODULE_NAME} - Item name is nil or invalid.`) return end
    local PlayerData = InventoryManager:GetInventory(Player)
    if not PlayerData then return end
end

function inventoryControler.ReplaceMask(Player: Player, Item: string): ()
    local PlayerData = InventoryManager:GetInventory(Player)
    if not PlayerData then return end
    PlayerData:equipMask(Item)
    return true
end

function inventoryControler.GetInventory(Player: Player, InventoryType: string): string
    if InventoryType == "MASK" then
        return InventoryManager:GetInventory(Player).Inventory.Masks
    elseif InventoryType == "GIFT" then
        return InventoryManager:GetInventory(Player).Inventory.Gifts
    end
end

function inventoryControler.openGift(Player: Player, gift: string): {[string]: {}}
    local PlayerData = InventoryManager:GetInventory(Player)
    if not PlayerData then return end
    
    local Gifts = luckModule.init(PlayerData.luck, gift)
    if not Gifts then warn(`{MODULE_NAME} - Gift generetor error (return nil or false).`) return end
    --PlayerData:removeGiftInInventory(index)
    
    return Gifts
end

function inventoryControler.CurrentMask(Player: Player) return InventoryManager:GetInventory(Player).CurrentMask end

return inventoryControler