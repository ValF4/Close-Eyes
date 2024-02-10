local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local LobbyShopFire = Bridgnet2.ReferenceBridge("LobbyShop")
local TestShopFire = Bridgnet2.ReferenceBridge("TesteShop")

local ShopList: {} = {
	["LobbyShop"] = function(Character)
		local GetPlayer = Players:GetPlayerFromCharacter(Character)
		print("Cheguei aqui")
		if not GetPlayer then return end
		LobbyShopFire:Fire(GetPlayer, GetPlayer)
	end,
}

return ShopList
