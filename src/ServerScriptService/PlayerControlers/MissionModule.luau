local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local InventoryManager = require(ServerStorage.Services.InventoryMananger)
local MissionList = require(ServerScriptService.ServerLists.MissionsList)
local WeekMissionList = require(ReplicatedStorage.ClientServices.ModuleLists.MissionWeekList)

local UpgradeProcressBar = Bridgnet2.ReferenceBridge("UPGRADE_PROCRESS_BAR")

local MissionModule = {}

local WeekSecond: number = 604800
local MaxMissions: number = 4

local MissionsTypes = {
    ["GoldemCollet"] = {
        "MISSION_1",
    },

    ["BrowmCollet"] = {
        "MISSION_7"
    },

    ["SequenceWins"] = {
        "MISSION_5"
    },

    ["BallonsCollet"] = {
        "MISSION_3"
    },

    ["RuningMap"] = {
        "MISSION_4"
    },

    ["WinEpicItens"] = {
        "MISSION_2"
    },

    ["stereggMap"] = {
        "MISSION_6"
    }
}

local function HasMission(playerData, missionId): boolean
    for _, missionInfo in playerData.Missions do
      if missionInfo.MissionID == missionId then return false end
    end
    return true
end

local function SetMissions(Player: Player): ()
    while task.wait() do
        local playerData = InventoryManager:GetInventory(Player)
        local playerMissions = playerData.Missions
        local missionInfo = MissionList[math.random(1, #MissionList)]
      
        if #playerMissions >= MaxMissions then break end
        if not HasMission(playerData, missionInfo.MissionID) then continue end
     
        local missionData = {["MissionID"] = missionInfo.MissionID, ["Progress"] = 0}
        playerData:SetMission(missionData)

    end
end

local function UpgradeMissionList(Player: Player): ()
    local PlayerData
    local PlayerMissionList
    local i: number = 1

    while task.wait() do
        PlayerData = InventoryManager:GetInventory(Player)
        PlayerMissionList = PlayerData.Missions
        if #PlayerMissionList == 0 then i = 1 break end
        PlayerData:RemoveMission(i)
        i += 1
    end

    SetMissions(Player)
end


function MissionModule.CheskingNewPlayer(Player: Player): ()
    local PlayerData = InventoryManager:GetInventory(Player)

    local lastUpdate = PlayerData.lastEntry or 0

    local lastWeek = math.floor(lastUpdate/WeekSecond)
    local week = math.floor(tick()/WeekSecond)
  
    if lastWeek ~= week then
        PlayerData:setLastEntry(math.floor(week * WeekSecond))
        UpgradeMissionList(Player)
    end
end

function MissionModule.GetMissions(Player: Player): {string}
    if not Player then return end
    local GetPlayerData = InventoryManager:GetInventory(Player)
    return GetPlayerData.Missions
end

function MissionModule.CheckingMissionsStatus(PlayerID: string, List: {[string]: string | number})
    local Player: Player = Players:GetPlayerByUserId(PlayerID)
    local PlayerData = InventoryManager:GetInventory(Player)
    local PlayerMissionList = PlayerData.Missions
    local MissionsList: {[string]: string} = MissionsTypes[List.ReferenceMission]

    if not MissionList then return end

    for _: number, MissionList: string in MissionsList do
        for index: number, Mission: {[string]: string | number} in PlayerMissionList do
            if MissionList ~= Mission.MissionID or Mission.Progress >= WeekMissionList[Mission.MissionID].Total_Mission then continue end
            
            PlayerData:SetProcress(index, List.Value)
            UpgradeProcressBar:Fire(Player, {["Player"] = Player, ["Mission"] = Mission})
        end
    end
end

return MissionModule