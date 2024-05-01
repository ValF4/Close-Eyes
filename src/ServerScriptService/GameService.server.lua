local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage =  game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local ChekingUpgrade = require(ServerScriptService.PlayerControlers.CheckingUpgrade)
local BillBordControl = require(ReplicatedStorage.GuiModuleControler.BillBordControl)
local CharacterControler = require(ServerScriptService.PlayerControlers.CharacterControler)
local InitMarksServices = require(ServerScriptService.MarkesControlers.InitMarksModule)
local DataManager = require(ServerStorage.Services.DataMananger)
local DataControler = require(ServerScriptService.PlayerControlers.DataControler)
local CodeRecompenseSystem = require(ServerScriptService.PlayerControlers.codeSystem)

local TeleportPlayerEvent = Bridgnet2.ServerBridge("TeleportPlayer")
local AnchoredPlayerEvent = Bridgnet2.ServerBridge("AnchoredPlayer")
local CodeSystemEvent = Bridgnet2.ServerBridge("CodeSystem")
local GetVersion = Bridgnet2.ServerBridge("GetVersion")

DataManager.Init()
InitMarksServices.InitMarks()
CharacterControler.InitControlers()
BillBordControl:ViewPortControler()

TeleportPlayerEvent:Connect(function(Player: Player, Coords: Vector3): () CharacterControler.TeleportService(Player, Coords) end)
AnchoredPlayerEvent:Connect(function(Player: Player, State: boolean): () CharacterControler.AnchoredCharacterControler(Player, State) end)

CodeSystemEvent.OnServerInvoke = function(Player: Player?, codeInInput: string?): boolean
    if not codeInInput then return end 
    return CodeRecompenseSystem.checkingList(Player, codeInInput)
end

GetVersion.OnServerInvoke = function(Player: Player): string
    if not Player then return end  
    return ChekingUpgrade.GetVersion(Player)
end

Players.PlayerAdded:Connect(function(player: Player): ()
    DataControler.NewPlayer(player)
    ChekingUpgrade.Cheking(player)
end)

--local Variavel = Bridgnet2.ServerBridge("NOMEDOREMOTE")

--Variavel.Fire("Player",local content = {contente1,content2})

--recerber

--Variavel.Connect(function(Player,Content) <SCOPO> end)

