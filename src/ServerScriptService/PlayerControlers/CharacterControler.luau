local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local InitCharacterControler = {}

function InitCharacterControler.TeleportService(Player: Player, cord: Vector3): ()
    if not cord or not Player then return end

    local Character: Model = Player.Character

    Character:PivotTo(CFrame.new(cord) * CFrame.Angles(0, math.rad(-120), 0))
end

function InitCharacterControler.AnchoredCharacterControler(_, Content): ()
    if not Content or Content.State == nil then return end

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