local Players           = game:GetService("Players")
local ReplicatedFirst   = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService      = game:GetService("TweenService")

local Player: Player = Players.LocalPlayer

local UpgradeList = require(ReplicatedStorage.ClientServices.ModuleLists.Upgrades)

local DefaltAnimation: TweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear)

local upgradeGui = {}
local InUpgradeGui: {TextLabel} = {}

function upgradeGui.InitGui(Content: {string}): ()
    if not Content then return end

    local GetPlayerGui: PlayerGui = Player.PlayerGui

    local GetUpgradeGui: ScreenGui = GetPlayerGui:WaitForChild("UpgradeGui")
    local BackgroundUpgradeGui: Frame = GetUpgradeGui:FindFirstChild("background")
    local CloseBottom: ImageButton = BackgroundUpgradeGui:FindFirstChild("Exit")

    local TemplateFiles: Folder = BackgroundUpgradeGui:FindFirstChild("Contents")
    local WallpaperTemplate: ImageLabel = TemplateFiles:FindFirstChild("Wallpaper")
    local InfosTemplates: TextLabel = TemplateFiles:FindFirstChild("info_Template")

    local UpgradeScrolling: ScrollingFrame = BackgroundUpgradeGui:FindFirstChild("ScrollingFrame")

    if not GetUpgradeGui or not CloseBottom then return end

    local GetUpgradeList: {} = UpgradeList[Content.GetVersion]
    if not GetUpgradeList then return end

    repeat task.wait() until not ReplicatedFirst:GetAttribute("IN_WELCOME")
    GetUpgradeGui.Enabled = true
    ReplicatedFirst:SetAttribute("UpgradeGui", true)

    for Type: string, Iten: string in GetUpgradeList do
         if tostring(Type) == "Configs" then
            local UpgradeTemplate: TextLabel = WallpaperTemplate:Clone()
            UpgradeTemplate.Image = Iten.Image_Id
            UpgradeTemplate.U_Version.Text = Iten.Title_Version
            UpgradeTemplate.N_Version.Text = Iten.Name_Version
            UpgradeTemplate.Name = Type
            UpgradeTemplate.LayoutOrder = -1
            UpgradeTemplate.Parent = UpgradeScrolling
            UpgradeTemplate.Visible = true
            table.insert(InUpgradeGui, UpgradeTemplate)
        elseif tostring(Type) == "Topics" then
            for Index: number, Topic: string in Iten do
                local UpgradeTopic: TextLabel = InfosTemplates:Clone()
                UpgradeTopic.Name = Index
                UpgradeTopic.Text = Topic
                UpgradeTopic.Parent = UpgradeScrolling
                UpgradeTopic.Visible = true
                table.insert(InUpgradeGui, UpgradeTopic)
            end
        end
    end
    TweenService:Create(BackgroundUpgradeGui, DefaltAnimation, {Position = UDim2.fromScale(0.5, 0.5)}):Play()

    CloseBottom.MouseEnter:Connect(function(x, y)
        TweenService:Create(CloseBottom, DefaltAnimation, {Size = UDim2.fromScale(0.07, 0.06)}):Play()
    end)

    CloseBottom.MouseLeave:Connect(function(x, y)
        TweenService:Create(CloseBottom, DefaltAnimation, {Size = UDim2.fromScale(0.06, 0.05)}):Play()
    end)

    CloseBottom.MouseButton1Click:Connect(function()
        SoundService:PlayLocalSound(SoundService.Guisounds.Press)
        local InitLeaveAnimation = TweenService:Create(BackgroundUpgradeGui, DefaltAnimation, {Position = UDim2.fromScale(0.5, 2)})
        InitLeaveAnimation:Play()
        InitLeaveAnimation.Completed:Connect(function()
            GetUpgradeGui.Enabled = false
            ReplicatedFirst:SetAttribute("UpgradeGui", nil)
            for i = 1, #InUpgradeGui do
                local Item: TextLabel = InUpgradeGui[1]
                Item:Destroy()
                table.remove(InUpgradeGui, 1)
            end
        end)
    end)
end

return upgradeGui
