local ServerControlerModule = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local BillboardControl = require(ReplicatedStorage.GuiModuleControler.BillBordControl)

local MaxPlayers: number = 8

local allMarkes = {
    Mark_1 = {},
}

function ServerControlerModule.ListControler(Player: Player, Marker: Part, Option: string): ()
    if not Player or not Marker or not Option then return end

    local markerTable = allMarkes[Marker.Parent.Name]
    
    if not markerTable or #markerTable == MaxPlayers then return end

    local Index = table.find(markerTable, Player) 

    if Option == "ADD" then
        if Index then return end
        table.insert(markerTable, Player)
        BillboardControl.ViewPortControler(Marker.Parent, markerTable)
    elseif Option == "REMOVE" then
        if not Index then return end

        table.remove(markerTable, Index)
        BillboardControl.ViewPortControler(Marker.Parent, markerTable)
    else
        return warn("ERROR - Option Value is invalid")
    end
end

return ServerControlerModule
