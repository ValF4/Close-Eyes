local Workspace = game:GetService("Workspace")
local benchFolder: Folder = Workspace:WaitForChild("banco de praça")

local benchService = {}

function benchService.benchinit()
    for i: number, parkBench: Model in benchFolder:GetChildren() do
        if not parkBench:IsA("Model") then continue end
        for i: number, Iten: MeshPart in parkBench:GetChildren() do
            if not Iten:IsA("MeshPart") or Iten.name ~= "parkBenchWood" then continue end
            for i: number, sitModel: Model in Iten:GetChildren() do
                if not sitModel:IsA("Model") then continue end
                local seatService: Seat = sitModel.ClickTrigger.Seat
                local proximityService: ProximityPrompt = sitModel.ClickTrigger.ProximityPrompt

                proximityService.Triggered:Connect(function(plr)
                    if seatService.Occupant then return end
                
                    local char = plr.Character
                    if not char then return end
                
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if not humanoid then return end
                    
                    seatService:Sit(humanoid)
                end)

                seatService:GetPropertyChangedSignal("Occupant"):Connect(function()
                    local humanoid = seatService.Occupant
                    if humanoid then
                        proximityService.Enabled = false
                    else
                        proximityService.Enabled = true
                    end
                end)
            end
        end
    end
end

return benchService