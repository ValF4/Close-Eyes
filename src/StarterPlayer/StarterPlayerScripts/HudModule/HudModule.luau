local HudModule = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local UpgradeHud = Bridgnet2.ServerBridge("UpgradeHud")

local GuiUpgrade = require(ReplicatedStorage.ClientServices.ClientDataManager.DataClient)

function HudModule:init(Player)
    if not Player then return end

    local PlayerGui: PlayerGui = Player.PlayerGui
    
    local Hud: ScreenGui = PlayerGui:FindFirstChild("Hud")
    local InfoFrame: Frame = Hud:FindFirstChild("InfoFrame")

    if not Hud or not InfoFrame then return end
    
    local GemsText: TextLabel = InfoFrame:FindFirstChild("Gems")
    local MoneyText: TextLabel = InfoFrame:FindFirstChild("Money")

    if not GemsText or not MoneyText then return end

    local PlayerData = GuiUpgrade.GetData(Player)

    MoneyText.Text = "Coins: " ..PlayerData.Coins
    GemsText.Text = "Gems: " ..PlayerData.Gems
end

--function HudModule:UpgradeHud(Player: Player)
--    UpgradeHud:init(Player)
--end
--
--UpgradeHud:Connect(function(Player) HudModule:UpgradeHud() end)

return HudModule