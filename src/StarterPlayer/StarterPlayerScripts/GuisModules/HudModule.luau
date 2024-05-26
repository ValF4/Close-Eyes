local HudModule = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

function HudModule:init(Player): ()
    if not Player then return end

    local PlayerGui: PlayerGui = Player.PlayerGui
    
    local Hud: ScreenGui = PlayerGui:FindFirstChild("Hud")
    local Coins_Frame: Frame = Hud:FindFirstChild("Coins_Frame")

    if not Hud or not Coins_Frame then return end
    
    local getGoldemBackground: ImageLabel = Coins_Frame:FindFirstChild("Goldem_bottom_Background")
    local getBrowmBackground: ImageLabel = Coins_Frame:FindFirstChild("Brown_bottom_Background")

    local getGoldemText: TextLabel = getGoldemBackground:FindFirstChild("Goldem_Text")
    local getBrowmText: TextLabel = getBrowmBackground:FindFirstChild("Brown_Text")

    if not getGoldemText or not getBrowmText then return end

    local GetPlayersInfos: Configuration = Player.PlayerData

    getGoldemText.Text = GetPlayersInfos:GetAttribute("GoldemBottom")
    getBrowmText.Text = GetPlayersInfos:GetAttribute("BrowmBottom")

    GetPlayersInfos.AttributeChanged:Connect(function(attribute: string)
        if tostring(attribute) == "LastVersion" then return end

        getGoldemText.Text = GetPlayersInfos:GetAttribute("GoldemBottom")
        getBrowmText.Text = GetPlayersInfos:GetAttribute("BrowmBottom")
    end)
end

return HudModule