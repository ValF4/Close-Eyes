local Players = game:GetService("Players")

local InitCharacterControler = {}

--function InitCharacterControler.TeleportPlayer()
--    
--end

function InitCharacterControler.AnchoredCharacterControler(HumanoidRootPart: Part, State: boolean)
    
    if not HumanoidRootPart or State == nil then return end

    if State then
        HumanoidRootPart.Anchored = false
    else
        HumanoidRootPart.Anchored = true
    end
end

Players.PlayerAdded:Connect(function(player: Player)
    player.CharacterAdded:Connect(function(character)
        local GetHumanoitRootPart: Part = character:FindFirstChild("HumanoidRootPart")
        
        InitCharacterControler.AnchoredCharacterControler(GetHumanoitRootPart ,false)
    end)
end)

return InitCharacterControler