local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Player: Player = Players.LocalPlayer
local PlayerGui: PlayerGui = Player.PlayerGui

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local UpgradeList = require(ReplicatedStorage.ClientServices.ModuleLists.Upgrades)

local GET_VERSION = Bridgnet2.ReferenceBridge("GetVersion")

local timeControler = {}

local function GetVersion(): ()
    if not Player then return end
    local version: string = UpgradeList[GET_VERSION:InvokeServerAsync(Player)].Version
    return version
end 

function timeControler:init(): ()
    local HudScreem: ScreenGui = PlayerGui:WaitForChild("Hud")
    local TextVersion: TextLabel = HudScreem:WaitForChild("TextVersion")

    local Version: string = GetVersion()

    RunService.Heartbeat:Connect(function(_):()
        TextVersion.Text = `Game Version: {Version} | Life Server: {os.date("!%X", workspace.DistributedGameTime)}`
        task.wait(1)
    end)
end



return timeControler