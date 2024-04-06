local Player: Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerScript: PlayerScripts = Player.PlayerScripts

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local GuiControl = require(ReplicatedStorage.ClientServices.GuiControl)
local HudModule = require(PlayerScript.GuisModules.HudModule)
local UpgradeGui = require(PlayerScript.GuisModules.UpgradeGui)
local CodeGuiModule = require(PlayerScript.GuisModules.CodeModule)

local exchangeVersion = Bridgnet2.ClientBridge("exchangeVersion")
--local codeGuiControler = Bridgnet2.ClientBridge("codeGuiControler")

GuiControl:init(Player)
HudModule:init(Player)

exchangeVersion:Connect(function(Version: string) UpgradeGui.InitGui(Version) end)
--codeGuiControler:Connect(function() codeGuiControler:init(Player) end)