local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage =  game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local InventoryMananger = require(ServerStorage.Services.InventoryMananger)

local Variavel = Bridgnet2.ServerBridge("NOMEDOREMOTE")

--Variavel.Fire("Player",local content = {contente1,content2})

--recerber 

--Variavel.Connect(function(Player,Content) <SCOPO> end)