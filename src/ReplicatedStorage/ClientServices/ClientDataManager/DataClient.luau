local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local dataClient = {}

local GetInventory = Bridgnet2.ReferenceBridge("GetInventory")

function dataClient.GetData()
    return GetInventory:InvokeServerAsync()
end

return dataClient