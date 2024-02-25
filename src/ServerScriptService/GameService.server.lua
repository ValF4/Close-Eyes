local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage =  game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local CharacterControler = require(ServerScriptService.PlayerControlers.CharacterControler)
local InitMarksServices = require(ServerScriptService.MarkesControlers.InitMarksModule)
local InventoryMananger = require(ServerStorage.Services.InventoryMananger)
local DataManager = require(ServerStorage.Services.DataMananger)

--local InitGameServiceEvent = Bridgnet2.ServerBridge("InitGameService")
local TeleportPlayerEvent = Bridgnet2.ServerBridge("TeleportPlayer")
local AnchoredPlayerEvent = Bridgnet2.ServerBridge("AnchoredPlayer")

DataManager.Init()
InitMarksServices.InitMarks()
CharacterControler.InitControlers()

TeleportPlayerEvent:Connect(function(Player: Player, Coords: Vector3) CharacterControler.TeleportService(Player, Coords) end)
AnchoredPlayerEvent:Connect(function(Player: Player, State: boolean) CharacterControler.AnchoredCharacterControler(Player, State) end)
--InitGameServiceEvent:Connect(function(Player: Player) CharacterControler.Init(Player) end)

--local Variavel = Bridgnet2.ServerBridge("NOMEDOREMOTE")

--Variavel.Fire("Player",local content = {contente1,content2})

--recerber

--Variavel.Connect(function(Player,Content) <SCOPO> end)

