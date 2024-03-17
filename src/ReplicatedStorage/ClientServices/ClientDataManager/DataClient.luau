local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local dataClient = {}

local GetInventory = Bridgnet2.ReferenceBridge("GetInventory")

function dataClient.GetData(Player: Player)
    if not Player then return warn("Invalid Player") end

    local GetData = GetInventory:InvokeServerAsync()

    return GetData
end

return dataClient