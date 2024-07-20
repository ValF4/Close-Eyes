local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
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
    if table.getn(PlayerData.Inventory) ~= 0 then return end
    PlayerData:setItenInInventory(InitMask, Player)
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

function inventoryControler.GetInventory(Player: Player): {} return InventoryManager:GetInventory(Player).Inventory end

function inventoryControler.CurrentMask(Player: Player) print(InventoryManager:GetInventory(Player).CurrentMask) return InventoryManager:GetInventory(Player).CurrentMask end

return inventoryControler