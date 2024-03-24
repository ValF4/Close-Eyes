local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UpgradeListModule = require(ReplicatedStorage.ClientServices.ModuleLists.Upgrades)
local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local CheckingService = Bridgnet2.ReferenceBridge("CheckingAtribute")

local UpgradeGui = {}

function UpgradeGui.ChekingUpgrade(Player: Player): ()
    
    local GetVersion: string = CheckingService:InvokeServerAsync("Version")
    print(GetVersion)
    

    --if not GetVersion then return end
end

function UpgradeGui:init(Player: Player): ()
    if not Player then return end

    local GetPlayerGui: PlayerGui = Player.PlayerGui
    if not GetPlayerGui then return error("PlayerGui not find") end

    local GetUpgradeGui: ScreenGui = GetPlayerGui:FindFirstChild("UpgradeGui")
    if not GetUpgradeGui then return end

    local Upgrade = UpgradeGui.ChekingUpgrade(Player)

    GetUpgradeGui.Enabled = true
    
end

return UpgradeGui