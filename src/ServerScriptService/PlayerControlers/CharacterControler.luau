local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local InitCharacterControler = {}

function InitCharacterControler.TeleportService(Player: Player, cord: Vector3): ()
    if not cord then
        if not Player then return end

        local GetCharacter = Player.Character

        --Character:MoveTo(Vector3.new(cord.X, cord.Y, cord.Z)) -- TODO - Get cord in the teleportScritpService
    else
        local Character = Player.Character
--
	    Character:MoveTo(Vector3.new(cord.X, cord.Y, cord.Z))
    end

end

function InitCharacterControler.AnchoredCharacterControler(Player: Player, Content): ()
    if not Content or Content.State == nil then return warn("ERROR - HumanoidRootPart is invalid or nil.") end

    Content.HumanoitRootPart.Anchored = not Content.State

end

function InitCharacterControler.InitControlers(): ()
    Players.PlayerAdded:Connect(function(player: Player): ()
        player.CharacterAdded:Connect(function(character)
            local Content = {
                HumanoitRootPart = character:FindFirstChild("HumanoidRootPart"),
                State = false
            }

            InitCharacterControler.AnchoredCharacterControler(player, Content)
        end)
    end)
end

return InitCharacterControler