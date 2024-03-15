local HudModule = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

    print(GuiUpgrade.GetData(Player))
end

return HudModule