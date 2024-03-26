local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local InLoaded = true

local DefaltAnimation = TweenInfo.new(0.1, Enum.EasingStyle.Linear)

local Player = Players.LocalPlayer

local UpgradeList = require(ReplicatedStorage.ClientServices.ModuleLists.Upgrades)
local upgradeGui = {}
local InUpgradeGui = {}

function upgradeGui.InitGui(Version: string)
    if not Version then return end

    local GetPlayerGui: PlayerGui = Player.PlayerGui

    local GetUpgradeGui: ScreenGui = GetPlayerGui:FindFirstChild("UpgradeGui")
    local BackgroundUpgradeGui: Frame = GetUpgradeGui:FindFirstChild("background")
    local CloseBottom: ImageButton = BackgroundUpgradeGui:FindFirstChild("Exit")

    local TemplateTexts: Folder = BackgroundUpgradeGui:FindFirstChild("Contents")
    local ContentLabel: TextLabel = TemplateTexts:FindFirstChild("Content")
    local TitleLabel: TextLabel = TemplateTexts:FindFirstChild("Title")

    local UpgradeScrolling: ScrollingFrame = BackgroundUpgradeGui:FindFirstChild("ScrollingFrame")

    if not GetUpgradeGui or not CloseBottom then return end

    local GetUpgradeList: {} = UpgradeList[Version]
    if not GetUpgradeList then return end

    while true do task.wait()
        if not ReplicatedFirst:GetAttribute("IN_LOADING") then break end
    end

    GetUpgradeGui.Enabled = true

    for Type: string, Text: string in GetUpgradeList do
        if tostring(Type) == "Title" then
            local UpgradeTitle: TextLabel = TitleLabel:Clone()
            UpgradeTitle.Name = Text
            UpgradeTitle.Text = Text
            UpgradeTitle.Parent = UpgradeScrolling
            UpgradeTitle.Visible = true
            table.insert(InUpgradeGui, UpgradeTitle)
        elseif tostring(Type) == "Topics" then
            for Index: number, Topic: string in Text do
                local UpgradeTopic: TextLabel = ContentLabel:Clone()
                UpgradeTopic.Name = Index
                UpgradeTopic.Text = Topic
                UpgradeTopic.Parent = UpgradeScrolling
                UpgradeTopic.Visible = true
                table.insert(InUpgradeGui, UpgradeTopic)
            end
        end
    end

    print(InUpgradeGui)

    TweenService:Create(BackgroundUpgradeGui, DefaltAnimation, {Position = UDim2.fromScale(0.5, 0.5)}):Play()

    CloseBottom.MouseButton1Click:Connect(function()
        local InitLeaveAnimation = TweenService:Create(BackgroundUpgradeGui, DefaltAnimation, {Position = UDim2.fromScale(0.5, 2)})
        InitLeaveAnimation:Play()
        InitLeaveAnimation.Completed:Connect(function()
            GetUpgradeGui.Enabled = false
            for index: string | number, Item: TextLabel in InUpgradeGui do
                Item:Destroy()
                table.remove(InUpgradeGui, table.find(InUpgradeGui, index))
            end
            print(InUpgradeGui)
        end)
    end)

end

return upgradeGui
