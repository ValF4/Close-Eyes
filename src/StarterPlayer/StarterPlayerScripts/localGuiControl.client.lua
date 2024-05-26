local Player: Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerScript: PlayerScripts = Player.PlayerScripts

local Bridgnet2         = require(ReplicatedStorage.Packages.BridgeNet2)
local GuiControl        = require(ReplicatedStorage.ClientServices.GuiControl)
local HudModule         = require(PlayerScript.GuisModules.HudModule)
local TimeControler     = require(PlayerScript.GuisModules.TimeControler)
local UpgradeGui        = require(PlayerScript.GuisModules.UpgradeGui)
local leaderBordControl = require(PlayerScript.GuisModules.leaderbordControl)

local exchangeVersion   = Bridgnet2.ClientBridge("exchangeVersion")
local getInformations   = Bridgnet2.ClientBridge("getInformations")

GuiControl:init(Player)
HudModule:init(Player)
TimeControler.init()
leaderBordControl.init()

exchangeVersion:Connect(function(Version: string): () UpgradeGui.InitGui(Version) end)