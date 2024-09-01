local Player: Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerScript: PlayerScripts = Player.PlayerScripts

local GuiControl            = require(ReplicatedStorage.ClientServices.GuiControl)
local HudModule             = require(PlayerScript.GuisModules.HudModule)
local TimeControler         = require(PlayerScript.GuisModules.TimeControler)
local UpgradeGui            = require(PlayerScript.GuisModules.UpgradeGui)
local MissionModule         = require(PlayerScript.GuisModules.MissionModule)
local playerMachanics       = require(PlayerScript.clientFunctions.playerMechanics)

local Bridgnet2             = require(ReplicatedStorage.Packages.BridgeNet2)

local exchangeVersion       = Bridgnet2.ClientBridge("exchangeVersion")
local UpgradeProcressBar    = Bridgnet2.ClientBridge("UPGRADE_PROCRESS_BAR")

exchangeVersion:Connect(function(Content: {string}): () UpgradeGui.InitGui(Content) end)
UpgradeProcressBar:Connect(function(Content: string): () MissionModule.updateProgressBar(Content) end)

GuiControl:init(Player)
HudModule:init(Player)
playerMachanics.init(Player)
TimeControler.init()