local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage =  game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local InitShopService = require(ReplicatedStorage.GameServices.InitShop)
local InventoryMananger = require(ServerStorage.Services.InventoryMananger)
local DataManager = require(ServerStorage.Services.DataMananger)

local LobbyShopFire = Bridgnet2.ServerBridge("LobbyShop")
local TestShopFire = Bridgnet2.ServerBridge("TesteShop")

DataManager.Init()
InitShopService.InitShop()

--local Variavel = Bridgnet2.ServerBridge("NOMEDOREMOTE")

--Variavel.Fire("Player",local content = {contente1,content2})

--recerber 

--Variavel.Connect(function(Player,Content) <SCOPO> end)

