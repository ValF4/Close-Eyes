local BillBordControl = {}

local MaxPlayers: number = 8

function BillBordControl.ViewPortControler(MarkParent: Model ,Value: number): ()
    if not MarkParent or not Value then
        local GetAllMarkes = workspace.InitGameMarks:GetChildren() or workspace:WaitForChild("InitGameMarks"):GetChildren()

        for index: number, Maker: Model in GetAllMarkes do
            local GetBillBord = Maker.ViewPort.BillboardGui

            local GetTimerText: TextLabel = GetBillBord.Frame.Timer
            local GetTotalPlatersText: TextLabel = GetBillBord.Frame.TotalPlayer

            GetTotalPlatersText.Text = "0/"..MaxPlayers
        end
    else
        local GetBillBord: BillboardGui = MarkParent.ViewPort.BillboardGui
    
        if not GetBillBord then return warn("ERROR - Not find ViewPort or BillborGui") end
    
        local GetTimerText: TextLabel = GetBillBord.Frame.Timer
        local GetTotalPlatersText: TextLabel = GetBillBord.Frame.TotalPlayer
    
        if not GetTimerText or not GetTotalPlatersText then return warn("ERROR - Not find GetTimer our TotalPlayerText.") end
    
        print(Value)
        GetTotalPlatersText.Text = Value.."/"..MaxPlayers
    end
end

return BillBordControl