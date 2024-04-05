local HudModule = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

function HudModule:init(Player): ()
    if not Player then return end

    local PlayerGui: PlayerGui = Player.PlayerGui
    
    local Hud: ScreenGui = PlayerGui:FindFirstChild("Hud")
    local InfoFrame: Frame = Hud:FindFirstChild("InfoFrame")

    if not Hud or not InfoFrame then return end
    
    local GemsText: TextLabel = InfoFrame:FindFirstChild("Gems")
    local MoneyText: TextLabel = InfoFrame:FindFirstChild("Money")

    if not GemsText or not MoneyText then return end

    local GetPlayersInfos: Configuration = Player.PlayerData
    if not GetPlayersInfos then return end

    MoneyText.Text = "Coins: " ..GetPlayersInfos:GetAttribute("Coins")
    GemsText.Text = "Gems: " ..GetPlayersInfos:GetAttribute("Gems")

    GetPlayersInfos.AttributeChanged:Connect(function(attribute: string)
        if tostring(attribute) == "LastVersion" then return end

        MoneyText.Text = "Coins: " ..GetPlayersInfos:GetAttribute("Coins")
        GemsText.Text = "Gems: " ..GetPlayersInfos:GetAttribute("Gems")
        
    end)
end

return HudModule