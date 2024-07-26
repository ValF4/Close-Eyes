
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local MissionModule = {}

local DefaltTween = TweenInfo.new(.5, Enum.EasingStyle.Linear)

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local MissionWeekList = require(ReplicatedStorage.ClientServices.ModuleLists.MissionWeekList)

local GetMissions = Bridgnet2.ReferenceBridge("GET_MISSIONS")

local FullProcessSize = UDim2.fromScale(0.9, 0.8)

local function GetProcress(MissionProcress: number, PlayerProcress: number): number
    if MissionProcress == 0 then 
        return MissionProcress
    elseif PlayerProcress == 0 then
        return PlayerProcress
    else
        return math.floor(MissionProcress / PlayerProcress) * 100
    end
end

local function sizeUpdateBar(PlayerProcess: number, TotalSize: number): UDim2
    if PlayerProcess >= TotalSize then return FullProcessSize end
    return UDim2.fromScale(PlayerProcess / TotalSize, 0.8)
end

function MissionModule.updateProgressBar(Content: {[string]: string | number})
    local Player: Player = Content.Player
    local PlayerGui = Player.PlayerGui
    local GameGuis: Folder = PlayerGui:WaitForChild("GAME_GUIS")

    local MissionsGui: ScreenGui = GameGuis.MissionsGui
    local MainMissionFrame: Frame = MissionsGui.MainFrame
    local ScrollingMissions: ScrollingFrame = MainMissionFrame.ScrollingFrame

    local GetMissionFrame: ImageLabel = ScrollingMissions:FindFirstChild(Content.Mission.MissionID)
    
    if not GetMissionFrame or Content.Mission.Progress >= MissionWeekList[Content.Mission.MissionID].Total_Mission then return end

    local GetMissionInfos = MissionWeekList[tostring(Content.Mission.MissionID)]

    TweenService:Create(GetMissionFrame.ProgressBar.Progress.Size, DefaltTween, {Size = sizeUpdateBar(Content.Mission.Progress, GetMissionInfos.Total_Mission)}):Play()

    GetMissionFrame.ProgressBar.percentage.Text = `{GetProcress(Content.Mission.Progress, GetMissionInfos.Total_Mission)} / 100%`
end

function MissionModule.init(Player: Player)
    local PlayerGui = Player.PlayerGui
    local GameGuis: Folder = PlayerGui:WaitForChild("GAME_GUIS")

    local MissionsGui: ScreenGui = GameGuis.MissionsGui
    local MainMissionFrame: Frame = MissionsGui.MainFrame
    local Templates: Folder = MainMissionFrame.Templates
    local ScrollingMissions: ScrollingFrame = MainMissionFrame.ScrollingFrame

    local MissionList = GetMissions:InvokeServerAsync(Player)
    
    for _, Mission in MissionList do
        local GetMissionInfos = MissionWeekList[tostring(Mission.MissionID)]
        if not GetMissionInfos then continue end

        local MissionTemplate: ImageLabel = Templates.MissionTemplate:Clone()
        MissionTemplate.TitleMission.Text = GetMissionInfos.Name
        MissionTemplate.DescriptionMission.Text = GetMissionInfos.Description
        MissionTemplate.ProgressBar.percentage.Text = `{GetProcress(GetMissionInfos.Total_Mission, Mission.Progress)} / 100%`
        print(sizeUpdateBar(GetMissionInfos.Total_Mission, Mission.Progress))
        --MissionTemplate.ProgressBar.Progress.Size = sizeUpdateBar(GetMissionInfos.Total_Mission, Mission.Progress)

        for index, value in GetMissionInfos.Recompenses do
            local RecompenseTemplate: ImageLabel = Templates.RecompenseBackground:Clone()
            RecompenseTemplate.Name = `Recompense_{index}`
            RecompenseTemplate.RecompenseImg.Image = value.IMG
            RecompenseTemplate.RecompenseName.Text = value.RECOMPENSE_NAME
            RecompenseTemplate.Visible = true
            RecompenseTemplate.Parent = MissionTemplate.RecompenseFrame
        end

        MissionTemplate.Name = Mission.MissionID
        MissionTemplate.Parent = ScrollingMissions
        MissionTemplate.Visible = true
    end

    MainMissionFrame.ExitBottom.MouseButton1Down:Connect(function()
        for _, Iten: ImageLabel | UIListLayout in ScrollingMissions:GetChildren() do
            if Iten:IsA("ImageLabel") then Iten:Destroy() end
        end
    end)
end

return MissionModule