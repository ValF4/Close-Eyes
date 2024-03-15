local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage =  game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local BillBordControl = require(ReplicatedStorage.GuiModuleControler.BillBordControl)
local CharacterControler = require(ServerScriptService.PlayerControlers.CharacterControler)
local InitMarksServices = require(ServerScriptService.MarkesControlers.InitMarksModule)
local InventoryMananger = require(ServerStorage.Services.InventoryMananger)
local DataManager = require(ServerStorage.Services.DataMananger)

local TeleportPlayerEvent = Bridgnet2.ServerBridge("TeleportPlayer")
local AnchoredPlayerEvent = Bridgnet2.ServerBridge("AnchoredPlayer")
local GetInventory = Bridgnet2.ServerBridge("GetInventory")

DataManager.Init()
InitMarksServices.InitMarks()
CharacterControler.InitControlers()
BillBordControl:ViewPortControler()

TeleportPlayerEvent:Connect(function(Player: Player, Coords: Vector3) CharacterControler.TeleportService(Player, Coords) end)
AnchoredPlayerEvent:Connect(function(Player: Player, State: boolean) CharacterControler.AnchoredCharacterControler(Player, State) end)
GetInventory:Connect(function(Player: Player) return end) -- TODO Revisão
--local Variavel = Bridgnet2.ServerBridge("NOMEDOREMOTE")

--Variavel.Fire("Player",local content = {contente1,content2})

--recerber

--Variavel.Connect(function(Player,Content) <SCOPO> end)

