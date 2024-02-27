local ServerControlerModule = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local allMarkes = {
    Mark_1 = {},
    Mark_2 = {},
    Mark_3 = {}
}

function ServerControlerModule.ListControler(Player: Player, Marker: Part, Option: string)
    if not Player or not Marker or not Option then return end

    local markerTable= allMarkes[Marker.Parent.Name]
    
    if Option == "ADD" then
        if table.find(markerTable, Player) then return end

        table.insert(markerTable, Player)
        print(markerTable)
    elseif Option == "REMOVE" then
        if not table.find(markerTable, Player) then return end

        table.remove(markerTable, table.find(markerTable, Player.Name))
        print(markerTable)
    else
        return warn("ERROR - Option Value is invalid")
    end

end

return ServerControlerModule
