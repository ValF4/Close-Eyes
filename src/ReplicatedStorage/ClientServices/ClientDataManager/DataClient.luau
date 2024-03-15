local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local dataClient = {}

local GetInventory = Bridgnet2.ReferenceBridge("GetInventory")

function dataClient.GetData(Player: Player)
    if not Player then return warn("Invalid Player") end

    local Content = {
        Player,
        numb = 12
    }

    local GetData = GetInventory:Fire(Content)
    --print(GetData)
    return GetData
end

return dataClient