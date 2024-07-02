local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local SucessPurchase = Bridgnet2.ReferenceBridge("SucessPurchase")
local FailPurchase = Bridgnet2.ReferenceBridge("FailPurchase")

local timeInitAnimation: TweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

local GoldemStore = {}

local GUI_IN_SCREEM = UDim2.fromScale(0.5, 0.5)
local GUI_OFF_SCREEM = UDim2.fromScale(0.5, -2)

local FUNCTION_NAME = "[GOLDEM STORE] "

local function NoticePurchaseNotification(Content: {number | boolean})
    local Player = Players:GetPlayerByUserId(Content.PlayerID)

    local PlayerGui = Player.PlayerGui
    local Player_Guis: Folder = PlayerGui.GAME_GUIS
    local BuyGoldemSreemGui:ScreenGui = Player_Guis.BuyGoldemGui

    local MainBackground: Frame = BuyGoldemSreemGui.MainFrame
    local ConfirmTemplate: Folder = MainBackground.ConfirmTemplate

    if Content.Stats then
        local SucessSecureFrame: Frame = ConfirmTemplate.SucessSecureFrame
        local SucessFrame: Frame = SucessSecureFrame.SucessMensager
        local SucessBackground: ImageLabel = SucessFrame.Background

        SucessSecureFrame.Visible = true

        TweenService:Create(SucessSecureFrame, timeInitAnimation, {Position = GUI_IN_SCREEM}):Play()

        SucessBackground.ConfirmBottom.MouseButton1Down:Connect(function()
            TweenService:Create(SucessSecureFrame, timeInitAnimation, {Position = GUI_OFF_SCREEM}):Play()
        end)
    else
        local FailSecureFrame: Frame = ConfirmTemplate.FailSecureFrame
        local FailFrame: Frame = FailSecureFrame.FailMensager
        local FailBackground: ImageLabel = FailFrame.Background

        FailSecureFrame.Visible = true

        TweenService:Create(FailSecureFrame, timeInitAnimation, {Position = GUI_IN_SCREEM}):Play()

        FailBackground.ConfirmBottom.MouseButton1Down:Connect(function()
            TweenService:Create(FailSecureFrame, timeInitAnimation, {Position = GUI_OFF_SCREEM}):Play()
        end)
    end
end

function GoldemStore.init(Player: Player)

    local ListItens: {[number]: {string}} = require(ReplicatedStorage.ClientServices.ModuleLists.goldemBottomItens)

    if not Player then warn(`{FUNCTION_NAME} - Valor de Player não enviado.`) return end

    local PlayerGui = Player.PlayerGui
    local Player_Guis: Folder = PlayerGui:WaitForChild("GAME_GUIS")
    local BuyGoldemSreemGui:ScreenGui = Player_Guis.BuyGoldemGui

    local MainFrame: Frame = BuyGoldemSreemGui.MainFrame
    local CloseBottom = MainFrame.ExitBottom
    local TemplateFolder: Folder = MainFrame.TemplateIten
    local templateIten: ImageLabel = TemplateFolder.Template
    local BackgroundButtonList: Frame = MainFrame.ItensBackground

    local ConfirmFolder: Folder = MainFrame.ConfirmTemplate
    
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
        for _, Iten: Frame in ConfirmFolder:GetChildren() do
            if Iten.Position == GUI_IN_SCREEM then
                Iten.Position = GUI_OFF_SCREEM
            end
        end
        for _: number, iten: ImageLabel | UIAspectRatioConstraint | UIPadding | UIListLayout in BackgroundButtonList:GetChildren() do
            if iten:IsA("ImageLabel") then iten:Destroy() end
        end
    end)

    FailPurchase:Connect(function(Content: {number | boolean}) NoticePurchaseNotification(Content) end)
    SucessPurchase:Connect(function(Content: {number | boolean}) NoticePurchaseNotification(Content) end)
end

return GoldemStore