local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)
local InventoryManager = require(ServerStorage.Services.InventoryMananger)
local MissionList = require(ServerScriptService.ServerLists.MissionsList)

local MissionModule = {}

local WeekSecond: number = 604800
local MaxMissions: number = 4

local function SetMissions(Player: Player): ()
    while task.wait() do

        local PlayerData = InventoryManager:GetInventory(Player)
        local GetMissionList = PlayerData.Missions
        local RandomNumber: number = math.random(1, #MissionList)

        if #GetMissionList == 0 then
            local CreateContent = {["MissionID"] = MissionList[RandomNumber].MissionID, ["Progress"] = 0}
            PlayerData:SetMissions(CreateContent)
        end

        local Index: number = 1

        if #GetMissionList >= 4 then Index = nil break end

        local GetMission = MissionList[RandomNumber]

        if GetMission.MissionID == GetMissionList[Index].MissionID then continue end

        local CreateContent = {["MissionID"] = GetMission.MissionID, ["Progress"] = 0}
        
        PlayerData:SetMissions(CreateContent)
        
        Index += 1
    end
end

local function UpgradeMissionList(Player: Player): ()
    local PlayerData
    local PlayerMissionList
    local i: number = 1

    while task.wait() do
        PlayerData = InventoryManager:GetInventory(Player)
        PlayerMissionList = PlayerData.Missions
        if #PlayerMissionList == 0 then i = 1 return end
        PlayerData:RemoveMission(i)
        i += 1
    end

    SetMissions(Player)

end

local function CheskingNewPlayer(PlayerData)
    if PlayerData.lastEntry == 0 or not PlayerData.lastEntry then
        PlayerData:setLastEntry(math.floor(tick() / WeekSecond))
        return true
    end
    return
end

local function ChekingUpgradeDay(PlayerDB)
    local CurrentWeek: number = math.floor(tick() / WeekSecond)
    local PlayerWeek: number = math.floor(PlayerDB.lastEntry / WeekSecond)

    if CurrentWeek ~= PlayerWeek then return true end
    return
end

function MissionModule.CheckingMissions(Player: Player)
    local PlayerData = InventoryManager:GetInventory(Player)
    local CheckingNewPlayer: boolean = CheskingNewPlayer(PlayerData)
    local CheckingUpgradeDate: boolean = ChekingUpgradeDay(PlayerData)

    if CheckingNewPlayer then SetMissions(Player) end
    if CheckingNewPlayer then UpgradeMissionList(Player) end

    return
end

return MissionModule