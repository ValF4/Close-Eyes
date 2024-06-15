local ServerStorage = game:GetService("ServerStorage")

local inventoryManager = require(ServerStorage.Services.DataMananger)

local ConfigleaderStates = {}

function ConfigleaderStates.Config(player: Player)
    
    if not player then return end

    local getPlayerData = inventoryManager:GetData(player)

    local folder = Instance.new("Folder")
    folder.Name = "leaderstats"
    folder.Parent = player
    
    local BrownBottonInstance = Instance.new("IntValue")
    BrownBottonInstance.Name = "BrowmBottom"
    BrownBottonInstance.Value = getPlayerData.BrowmBottom
    BrownBottonInstance.Parent = folder

    local GoldemBottonInstance = Instance.new("IntValue")
    GoldemBottonInstance.Name = "GoldemBottom"
    GoldemBottonInstance.Value = getPlayerData.GoldemBottom
    GoldemBottonInstance.Parent = folder

    local GoldemBottonInstance = Instance.new("IntValue")
    GoldemBottonInstance.Name = "level"
    GoldemBottonInstance.Value = getPlayerData.Level
    GoldemBottonInstance.Parent = folder
end

return ConfigleaderStates