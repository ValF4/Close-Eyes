local Player: Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerScript: PlayerScripts = Player.PlayerScripts

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local GuiControl = require(ReplicatedStorage.ClientServices.GuiControl)
local HudModule = require(PlayerScript.GuisModules.HudModule)
local UpgradeGui = require(PlayerScript.GuisModules.UpgradeGui)

local exchangeVersion = Bridgnet2.ClientBridge("exchangeVersion")

GuiControl:init(Player)
HudModule:init(Player)

exchangeVersion:Connect(function(Version: string) UpgradeGui.InitGui(Version) end)