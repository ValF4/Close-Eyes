local player: Player = game:GetService("Players").LocalPlayer
local replicatedStore = game:GetService("ReplicatedStorage")
local playerGui: PlayerGui = player.PlayerGui

replicatedStore.Networks.RemotesEvents["DataManager/Client/GuiControl"].OnClientEvent:Connect(function(Player: Player)
	print("Entrei aq")
end)

