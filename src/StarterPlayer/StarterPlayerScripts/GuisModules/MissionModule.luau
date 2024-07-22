local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MissionModule = {}

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local MissionWeekList = require(ReplicatedStorage.ClientServices.ModuleLists.MissionWeekList)

local GetMissions = Bridgnet2.ReferenceBridge("GET_MISSIONS")

function updateProgressBar()
    
end

function MissionModule.init(Player: Player)
    local PlayerGui = Player.PlayerGui
    local GameGuis: Folder = PlayerGui:WaitForChild("GAME_GUIS")

    local MissionsGui: ScreenGui = GameGuis.MissionsGui
    local MainMissionFrame: Frame = MissionsGui.MainFrame
    local Templates: Folder = MainMissionFrame.Templates
    local ScrollingMissions: ScrollingFrame = MainMissionFrame.ScrollingFrame

    local MissionList = GetMissions:InvokeServerAsync(Player)

    local function GetProcress(MissionProcress: number, PlayerProcress: number): number
        return math.floor(MissionProcress / PlayerProcress) * 100
    end
    
    for _, Mission in MissionList do
        local GetMissionInfos = MissionWeekList[tostring(Mission.MissionID)]
        if not GetMissionInfos then continue end

        local MissionTemplate: ImageLabel = Templates.MissionTemplate:Clone()
        MissionTemplate.TitleMission.Text = GetMissionInfos.Name
        MissionTemplate.DescriptionMission.Text = GetMissionInfos.Description
        MissionTemplate.ProgressBar.percentage.Text = `{GetProcress(Mission.Progress, GetMissionInfos.Total_Mission)} / 100%`
        MissionTemplate.ProgressBar.Progress.Size = UDim2.fromScale(Mission.Progress / GetMissionInfos.Total_Mission, 0.8)

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