local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local processPayment = Bridgnet2.ReferenceBridge("processPayment")

local GoldemStore = {}

local FUNCTION_NAME = "[GOLDEM STORE] "

function GoldemStore.init(Player: Player)

    local ListItens: {[number]: {string}} = require(ReplicatedStorage.ClientServices.ModuleLists.goldemBottomItens)

    if not Player then warn(`{FUNCTION_NAME} - Valor de Player não enviado.`) return end

    local PlayerGui = Player.PlayerGui
    local Player_Guis: Folder = PlayerGui:WaitForChild("GAME_GUIS")
    local BuyGoldemSreemGui:ScreenGui = Player_Guis.BuyGoldemGui

    local MainFrame: Frame = BuyGoldemSreemGui.MainFrame
    local CloseBottom: ImageButton = MainFrame.ExitBottom
    local TemplateFolder: Folder = MainFrame.TemplateIten
    local templateIten: ImageLabel = TemplateFolder.Template
    local BackgroundButtonList: Frame = MainFrame.ItensBackground
    
    for i: number, iten: {[string]: string} in ListItens do
        
        local templateBuyBottons: ImageLabel = templateIten:Clone()

        templateBuyBottons.RobuxValue.Text = iten.titleTop
        templateBuyBottons.ImageLabel.Image = iten.ItenImgID
        templateBuyBottons.GoldenLabel.Text = iten.ItenName
        templateBuyBottons.BonusGoldemLAbel.Text = iten.BonusText
        templateBuyBottons.Name = iten.ItenName

        templateBuyBottons.LayoutOrder = i
        templateBuyBottons.Parent = BackgroundButtonList
        templateBuyBottons.Visible = true

        templateBuyBottons.BuyBottom.MouseButton1Down:Connect(function()
            MarketplaceService:PromptProductPurchase(Player, iten.ProductDeveloper)
        end)
    end

    CloseBottom.MouseButton1Down:Connect(function()
        for _: number, iten: ImageLabel | UIAspectRatioConstraint | UIPadding | UIListLayout in BackgroundButtonList:GetChildren() do
            if iten:IsA("ImageLabel") then iten:Destroy() end
        end
    end)
end

return GoldemStore