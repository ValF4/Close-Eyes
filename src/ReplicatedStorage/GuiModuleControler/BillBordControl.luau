local BillBordControl = {}

local BreakConter: boolean

local MaxPlayers: number = 8
local MaxTemp: number = 120
local MinTemp: number = 10

function timer(TextEdit: TextLabel, TotalInMarker: number): ()
    if not TextEdit or not TotalInMarker then return end

    if TotalInMarker == MaxPlayers then
        for TimeLeft: number = MinTemp, 0, -1 do
            print(TotalInMarker)
            if TotalInMarker == 0 then break end
            TextEdit.Text = "Iniciando em: " ..string.format("%02d : %02d", math.floor(TimeLeft / 60), math.floor(TimeLeft % 60))
            if TimeLeft == 0 then
                print("Partida iniciada")
            end
            task.wait(1)
        end
    else
        for TimeLeft: number = MaxTemp, 0, -1 do
            if TotalInMarker == 0 then
                BreakConter = true
                TextEdit.Text = "Iniciando em: Aguardando jogadores"
                break
            end
            if BreakConter then BreakConter = false return end
            if TotalInMarker == 0 then TextEdit.Text = "Aguardando jogadores" return end
            TextEdit.Text = "Iniciando em: " ..string.format("%02d : %02d", math.floor(TimeLeft / 60), math.floor(TimeLeft % 60))
            if TimeLeft == 0 then
                print("Partida iniciada")
            end
            task.wait(1)
        end
    end
end


function BillBordControl.ViewPortControler(MarkParent: Model ,Value: number): ()
    if not MarkParent or not Value then
        local GetAllMarkes = workspace.InitGameMarks:GetChildren() or workspace:WaitForChild("InitGameMarks"):GetChildren()

        for index: number, Maker: Model in GetAllMarkes do
            local GetBillBord = Maker.ViewPort.BillboardGui

            local GetTimerText: TextLabel = GetBillBord.Frame.Timer
            local GetTotalPlatersText: TextLabel = GetBillBord.Frame.TotalPlayer

            GetTotalPlatersText.Text = "0/"..MaxPlayers
            timer(GetTimerText, Value)
        end
    else
        local GetBillBord: BillboardGui = MarkParent.ViewPort.BillboardGui
    
        if not GetBillBord then return warn("ERROR - Not find ViewPort or BillborGui") end
    
        local GetTimerText: TextLabel = GetBillBord.Frame.Timer
        local GetTotalPlatersText: TextLabel = GetBillBord.Frame.TotalPlayer
    
        if not GetTimerText or not GetTotalPlatersText then return warn("ERROR - Not find GetTimer our TotalPlayerText.") end
    
        GetTotalPlatersText.Text = Value.."/"..MaxPlayers
        timer(GetTimerText, Value)
    end
end

return BillBordControl