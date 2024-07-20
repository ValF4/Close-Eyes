local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage =  game:GetService("ServerStorage")
local Players = game:GetService("Players")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local MissionModule = require(ServerScriptService.PlayerControlers.MissionModule)
local ChekingUpgrade = require(ServerScriptService.PlayerControlers.CheckingUpgrade)
local BillBordControl = require(ReplicatedStorage.GuiModuleControler.BillBordControl)
local CharacterControler = require(ServerScriptService.PlayerControlers.CharacterControler)
local InitMarksServices = require(ServerScriptService.MarkesControlers.InitMarksModule)
local DataManager = require(ServerStorage.Services.DataMananger)
local DataControler = require(ServerScriptService.PlayerControlers.DataControler)
local CodeRecompenseSystem = require(ServerScriptService.PlayerControlers.codeSystem)
local GameFunctions = require(ServerScriptService.GameFunctions.benchService)
local ConfigleaderStates = require(ServerScriptService.PlayerControlers.ConfigleaderStates)
local ProcessReceipt = require(ServerScriptService.GameFunctions.processReceipt)
local InventoryModule = require(ServerScriptService.PlayerControlers.InventoryControler)

local TeleportPlayerEvent = Bridgnet2.ServerBridge("TeleportPlayer")
local AnchoredPlayerEvent = Bridgnet2.ServerBridge("AnchoredPlayer")
local CodeSystemEvent = Bridgnet2.ServerBridge("CodeSystem")
local GetVersion = Bridgnet2.ServerBridge("GetVersion")
local FailPurchase = Bridgnet2.ServerBridge("FailPurchase")
local GetPlayerInventory = Bridgnet2.ServerBridge("GET_INVENTORY")
local GetMissions = Bridgnet2.ServerBridge("GET_MISSIONS")
local EquipItem = Bridgnet2.ServerBridge("EQUIP_ITEM")
local GetCurrentMask = Bridgnet2.ServerBridge("GET_CURRENT_MASK")

DataManager.Init()
InitMarksServices.InitMarks()
CharacterControler.InitControlers()
BillBordControl:ViewPortControler()
GameFunctions.benchinit()

TeleportPlayerEvent:Connect(function(Player: Player, Coords: Vector3): () CharacterControler.TeleportService(Player, Coords) end)
AnchoredPlayerEvent:Connect(function(Player: Player, State: boolean): () CharacterControler.AnchoredCharacterControler(Player, State) end)

EquipItem.OnServerInvoke = function(Player:Player , Item: string): ()
    if not Player or not Item then return end
    return InventoryModule.ReplaceMask(Player, Item)
end

GetCurrentMask.OnServerInvoke = function(Player: Player): ()
    if not Player then return end
    return InventoryModule.CurrentMask(Player)
end

GetPlayerInventory.OnServerInvoke = function(Player: Player): {}
    if not Player then return end
    return InventoryModule.GetInventory(Player)
end

GetMissions.OnServerInvoke = function(Player): ()
    if not Player then return end
    return MissionModule.GetMissions(Player)
end

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
    ConfigleaderStates.Config(player)
    InventoryModule.CheckingNewPlayer(player)
    ChekingUpgrade.Checking(player)
    MissionModule.CheskingNewPlayer(player)
end)

MarketplaceService.PromptProductPurchaseFinished:Connect(function(PlayerID: Player, ProtuctID: string, Stats: boolean): RBXScriptSignal
    
    local Content = {['PlayerID'] = PlayerID, ['Stats'] = Stats}
    
    if not Stats then
        FailPurchase:Fire(Players:GetPlayerByUserId(PlayerID), Content)
    else
        ProcessReceipt.Process(PlayerID, ProtuctID, Content)
    end
end)

--local Variavel = Bridgnet2.ServerBridge("NOMEDOREMOTE")

--Variavel:Fire("Player",local content = {contente1,content2})

--recerber

--Variavel.Connect(function(Player,Content) <SCOPO> end)

