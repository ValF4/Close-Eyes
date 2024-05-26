local ServerControlerModule = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local BillBordControl = require(ReplicatedStorage.GuiModuleControler.BillBordControl)

local MaxPlayers: number = 8

local allMarkes = {
    Mark_1 = {},
}

function ServerControlerModule.ListControler(Player: Player, Marker: Part, Option: string): ()
    if not Player or not Marker or not Option then return end

    local markerTable = allMarkes[Marker.Parent.Name]
    
    if not markerTable or #markerTable == MaxPlayers then return end

    if Option == "ADD" then
        if table.find(markerTable, Player) then return end
        table.insert(markerTable, Player)
        BillBordControl.ViewPortControler(Marker.Parent, #markerTable)
    elseif Option == "REMOVE" then
        if not table.find(markerTable, Player) then return end

        table.remove(markerTable, table.find(markerTable, Player.Name))
        BillBordControl.ViewPortControler(Marker.Parent, #markerTable)
    else
        return warn("ERROR - Option Value is invalid")
    end
end

return ServerControlerModule
