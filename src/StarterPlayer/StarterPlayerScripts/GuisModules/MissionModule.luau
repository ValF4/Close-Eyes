local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MissionModule = {}

local MissionWeekList = require(ReplicatedStorage.ClientServices.ModuleLists.MissionWeekList)

function MissionModule.init(Player: Player)
    return
--    local PlayerGui = Player.PlayerGui
--    local GameGuis: Folder = PlayerGui:WaitForChild("GAME_GUIS")
--
--    local MissionsGui: ScreenGui = GameGuis.MissionsGui
--    local MainMissionFrame: Frame = MissionsGui.MainFrame
--    local Templates: Folder = MainMissionFrame.Templates
--    local ScrollingMissions: ScrollingFrame = MainMissionFrame.ScrollingFrame
--
--    for index, value in MissionWeekList do
--        print(index)
--        print(value)
--    end
--
--    MainMissionFrame.ExitBottom.MouseButton1Down:Connect(function()
--        for _, Iten: ImageLabel | UIListLayout in ScrollingMissions:GetChildren() do
--            if Iten:IsA("ImageLabel") then Iten:Destroy() end
--        end
--    end)
end

return MissionModule