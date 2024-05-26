local ServerStorage = game:GetService("ServerStorage")

local InventoryMananger = require(ServerStorage.Services.InventoryMananger)

local DataControler = {}

function DataControler.NewPlayer(Player: Player): ()
    if not Player then return end

    local SetConfiguration = Instance.new("Configuration")
    SetConfiguration.Name = "PlayerData"

    SetConfiguration:SetAttribute("BrowmBottom", 0)
    SetConfiguration:SetAttribute("GoldemBottom", 0)
    SetConfiguration:SetAttribute("LastVersion", "")

    SetConfiguration.Parent = Player

    local getData = InventoryMananger:GetInventory(Player)
    if not getData then return warn("ERROR - erro in get player data.") end

    SetConfiguration:SetAttribute("BrowmBottom", getData.BrowmBottom)
    SetConfiguration:SetAttribute("GoldemBottom", getData.GoldemBottom)
    SetConfiguration:SetAttribute("LastVersion", getData.Config.Version)
end

function DataControler.UpgradeData(Player: Player): ()
    if not Player then return end
    local getData = InventoryMananger:GetInventory(Player)
    return
end

return DataControler